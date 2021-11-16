//
//  ScannerFlowViewModel.swift
//  ScannerFlow
//
//  Created by Filipe da Cruz Ribeiro on 12/11/21.
//

import Foundation
import Vision

@available(iOS 15.0, *)
protocol ScannerFlowViewModelProtocol {
    func setup(_ delegate: ScannerFlowViewModelDelegate)
    func performRequest(from image: CGImage)
}

protocol ScannerFlowViewModelDelegate: AnyObject {
    func render(_ dataSource: ScannerFlow.DataSource.UserInfo)
}

@available(iOS 15.0, *)
final class ScannerFlowViewModel {

    private weak var delegate: ScannerFlowViewModelDelegate?

    private var recognizeTextRequest: VNRecognizeTextRequest?

    init() {
        setupRecognizeTextRequest()
    }

    private func setupRecognizeTextRequest() {
        recognizeTextRequest = VNRecognizeTextRequest { [weak self] request, error in
            guard let self = self,
                  let observations = request.results as? [VNRecognizedTextObservation],
                  error == nil else { return }

            let stringObservations = observations.compactMap {
                $0.topCandidates(1).first?.string
            }

            self.renderFirstFullName(stringObservations: stringObservations)
        }
    }


    private func renderFirstFullName(stringObservations: [String]) {
        let firstFullName = stringObservations.filter { item in
            let wordCount = item.components(separatedBy: " ").count
            return wordCount >= 3 && wordCount <= 6
        }

        self.delegate?.render(.init(recognizedName: firstFullName.first ?? "name not found"))
    }
}

@available(iOS 15.0, *)
extension ScannerFlowViewModel: ScannerFlowViewModelProtocol {
    func performRequest(from image: CGImage) {
        let requestHandler = VNImageRequestHandler(cgImage: image, options: [:])
        do {
            guard let request = recognizeTextRequest else { return }
            try requestHandler.perform([request])
        } catch {
            fatalError()
        }
    }

    func setup(_ delegate: ScannerFlowViewModelDelegate) {
        self.delegate = delegate
    }
}
