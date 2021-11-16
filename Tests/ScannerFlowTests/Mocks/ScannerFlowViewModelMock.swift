//
//  File.swift
//  
//
//  Created by Filipe da Cruz Ribeiro on 15/11/21.
//

import Foundation
import UIKit
@testable import ScannerFlow

class ScannerFlowViewModelMock: ScannerFlowViewModelProtocol {
    var setupWasCalled = false
    var performRequest = false

    func setup(_ delegate: ScannerFlowViewModelDelegate) {
        setupWasCalled = true
    }

    func performRequest(from image: CGImage) {
        performRequest = true
    }
}
