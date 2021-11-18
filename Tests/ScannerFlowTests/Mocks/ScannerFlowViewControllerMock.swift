//
//  ScannerFlowViewControllerMock.swift
//  
//
//  Created by Filipe da Cruz Ribeiro on 15/11/21.
//

import Foundation
@testable import ScannerFlow
import UIKit

class ScannerFlowViewControllerMock: ScannerFlowViewModelDelegate {
    var renderCalledWithName: [String] = []

    func render(_ dataSource: ScannerFlow.DataSource.UserInfo) {
        renderCalledWithName = dataSource.recognizedText
    }
}
