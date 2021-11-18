//
//  File.swift
//  
//
//  Created by Filipe da Cruz Ribeiro on 17/11/21.
//

import Foundation
import XCTest
import SnapshotTesting
@testable import ScannerFlow

class ScannerFlowSnapshotTests: XCTestCase {

    var view: ScannerFlowView!

    override func setUp() {
        view = ScannerFlowView()
    }

/// Run only on iphone 8 target
    func testScannerFlowView_whenInitializedWithName_shouldMatchSnapshot() {
        let iphone8Size = CGSize(width: 750, height: 1344)
        assertSnapshot(
            matching: view,
            as: .image(size: iphone8Size),
            file: #file,
            testName: #function,
            line: #line
        )
    }
}
