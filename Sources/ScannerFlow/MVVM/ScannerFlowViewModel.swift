//
//  ScannerFlowViewModel.swift
//  ScannerFlow
//
//  Created by Filipe da Cruz Ribeiro on 12/11/21.
//

import Foundation
import Vision

protocol ScannerFlowViewModelProtocol {
    func setup(_ delegate: ScannerFlowViewModelDelegate)
    func performRequest(from image: CGImage)
}

protocol ScannerFlowViewModelDelegate: AnyObject {
    func render(_ dataSource: ScannerFlow.DataSource.UserInfo)
}

@available(iOS 13.0, *)
final class ScannerFlowViewModel {

    private weak var delegate: ScannerFlowViewModelDelegate?

    private lazy var recognizeTextRequest = VNRecognizeTextRequest(completionHandler: self.setupRecognizeTextRequest)

    private func setupRecognizeTextRequest(request: VNRequest, error: Error?) {
        guard  let observations = request.results as? [VNRecognizedTextObservation],
               error == nil else { return }

        let stringObservations = observations.compactMap {
            $0.topCandidates(1).first?.string
        }

        self.delegate?.render(
            .init(recognizedText: stringObservations)
        )
    }
}

@available(iOS 13.0, *)
extension ScannerFlowViewModel: ScannerFlowViewModelProtocol {
    func performRequest(from image: CGImage) {
        let requestHandler = VNImageRequestHandler(cgImage: image, options: [:])
        do {
            try requestHandler.perform([recognizeTextRequest])
        } catch {
            fatalError()
        }
    }

    func setup(_ delegate: ScannerFlowViewModelDelegate) {
        self.delegate = delegate
    }
}
