////
////  ScannerFlowSnapshotTests.swift
////
////
////  Created by Filipe da Cruz Ribeiro on 15/11/21.
////
//
//import XCTest
//import SnapshotTesting
//@testable import ScannerFlow
//
//final class ScannerFlowSnapshotTests: XCTestCase {
//
//    var view: ScannerFlowViewProtocol!
//
//    override func setUp() {
//        view = ScannerFlowView.make()
//    }
//
//    func testScannerFlowView_whenInitializedWithName_shouldMatchSnapshot() {
//        view.render(.init(recognizedName: "Filipe Cruz"))
//
//        assertSnapshot(matching: view, as: .image)
//    }
//}
