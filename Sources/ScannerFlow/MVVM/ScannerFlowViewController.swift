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

@available(iOS 13.0, *)
final class ScannerFlowViewController: UIViewController {

    private let customView: ScannerFlowViewProtocol
    private let viewModel: ScannerFlowViewModelProtocol
    private let delegate: ScannerFlowDelegate
    private var documentCameraViewController: VNDocumentCameraViewController?

    init(
        customView: ScannerFlowViewProtocol,
        viewModel: ScannerFlowViewModelProtocol,
        delegate: ScannerFlowDelegate
    ) {
        self.customView = customView
        self.viewModel = viewModel
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func loadView() {
        view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.documentCameraViewController = VNDocumentCameraViewController()
        documentCameraViewController?.delegate = self
    }
}

@available(iOS 13.0, *)
extension ScannerFlowViewController: ScannerFlowViewModelDelegate {
    func render(_ dataSource: ScannerFlow.DataSource.UserInfo) {
        delegate.handleReconizedText(from: dataSource.recognizedText)
    }
}

@available(iOS 13.0, *)
extension ScannerFlowViewController: ScannerFlowViewDelegate {
    func openCamera() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized: // The user has previously granted access to the camera.
                guard let documentCameraViewController = self.documentCameraViewController else { return }
                self.present(documentCameraViewController, animated: true, completion: nil)
            @unknown default:
                requestCameraAcessAndOpen()
        }
    }

    private func requestCameraAcessAndOpen() {
        AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
            guard let self = self,
                  granted == true,
                  let documentCameraViewController = self.documentCameraViewController else { return }

            self.present(documentCameraViewController, animated: true, completion: nil)
        }
    }
}


@available(iOS 13.0, *)
extension ScannerFlowViewController: VNDocumentCameraViewControllerDelegate {
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
        dismiss(animated: true, completion: nil)

        for pageIndex in 0 ..< scan.pageCount {
            let image = scan.imageOfPage(at: pageIndex)
            if let cgImage = image.cgImage {
                viewModel.performRequest(from: cgImage)
            }
        }
    }
}
