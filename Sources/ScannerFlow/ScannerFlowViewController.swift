//
//  ScannerFlowViewController.swift
//  ScannerFlow
//
//  Created by Filipe da Cruz Ribeiro on 12/11/21.
//

import Foundation
import UIKit
import AVFoundation
import Vision
import VisionKit

@available(iOS 15.0, *)
final class ScannerFlowViewController: UIViewController {

    private let customView: ScannerFlowViewProtocol
    private let viewModel: ScannerFlowViewModelProtocol
    private let documentCameraViewController = VNDocumentCameraViewController()

    init(customView: ScannerFlowViewProtocol, viewModel: ScannerFlowViewModelProtocol) {
        self.customView = customView
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)

        documentCameraViewController.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func loadView() {
        view = customView
    }
}

@available(iOS 15.0, *)
extension ScannerFlowViewController: ScannerFlowViewModelDelegate {
    func render(_ dataSource: ScannerFlow.DataSource.UserInfo) {
        customView.render(dataSource)
    }
}

@available(iOS 15.0, *)
extension ScannerFlowViewController: ScannerFlowViewDelegate {
    func openCamera() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized: // The user has previously granted access to the camera.
                self.present(documentCameraViewController, animated: true, completion: nil)

            case .notDetermined: // The user has not yet been asked for camera access.
                requestCameraAcessAndOpen()

            case .denied: // The user has previously denied access.
                requestCameraAcessAndOpen()

            case .restricted: // The user can't grant access due to restrictions.
                requestCameraAcessAndOpen()

            @unknown default:
                fatalError()
        }
    }

    private func requestCameraAcessAndOpen() {
        AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
            guard let self = self,
                  granted == true else { return }

            self.present(self.documentCameraViewController, animated: true, completion: nil)
        }
    }
}


@available(iOS 15.0, *)
extension ScannerFlowViewController: VNDocumentCameraViewControllerDelegate {
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
        dismiss(animated: true, completion: nil)

        for pageIndex in 0 ..< scan.pageCount {
            let image = scan.imageOfPage(at: pageIndex)
            if let cgImage = image.cgImage {
                let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
                do {
                    guard let request = viewModel.recognizeTextRequest else { return }
                    try requestHandler.perform([request])
                } catch {
                    fatalError()
                }
            }
        }
    }
}
