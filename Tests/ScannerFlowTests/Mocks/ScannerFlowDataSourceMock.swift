//
//  File.swift
//  
//
//  Created by Filipe da Cruz Ribeiro on 15/11/21.
//

import Foundation
@testable import ScannerFlow

extension ScannerFlow.DataSource {
    static func mock() -> ScannerFlow.DataSource.UserInfo {
        return .init(recognizedText: [])
    }
}
