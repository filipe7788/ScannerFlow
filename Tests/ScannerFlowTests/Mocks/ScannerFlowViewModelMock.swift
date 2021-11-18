//
//  ScannerFlowViewModelMock.swift
//  
//
//  Created by Filipe da Cruz Ribeiro on 17/11/21.
//

import Foundation
import UIKit

@testable import ScannerFlow

class ScannerFlowViewModelMock: ScannerFlowViewModelProtocol {
    func setup(_ delegate: ScannerFlowViewModelDelegate) {}
    func performRequest(from image: CGImage) {}
}
