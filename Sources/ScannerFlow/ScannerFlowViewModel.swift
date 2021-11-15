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
    var recognizeTextRequest: VNRecognizeTextRequest? { get }
}

protocol ScannerFlowViewModelDelegate: AnyObject {
    func render(_ dataSource: ScannerFlow.DataSource.UserInfo)
}

@available(iOS 15.0, *)
final class ScannerFlowViewModel: ScannerFlowViewModelProtocol {
    private weak var delegate: ScannerFlowViewModelDelegate?

    private(set) var recognizeTextRequest: VNRecognizeTextRequest?

    init() {
        setupRecognizeTextRequest()
    }

    private func setupRecognizeTextRequest() {
        recognizeTextRequest = VNRecognizeTextRequest { [weak self] request, error in
            guard let self = self,
                  let observations = request.results as? [VNRecognizedTextObservation],
                  error == nil else { return }

            let text = observations.compactMap {
                $0.topCandidates(1).first?.string
            }

            let firstFullName = text.filter { item in
                let wordCount = item.components(separatedBy: " ").count
                return wordCount >= 3 && wordCount <= 6
            }

            self.delegate?.render(.init(recognizedName: firstFullName.first ?? "name not found"))
        }
    }

    func setup(_ delegate: ScannerFlowViewModelDelegate) {
        self.delegate = delegate
    }
}
