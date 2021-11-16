import Foundation
import XCTest
@testable import ScannerFlow

@available(iOS 15.0, *)
final class ScannerFlowViewControllerTests: XCTestCase {

    var viewModel: ScannerFlowViewModelMock!
    var customView: ScannerFlowViewProtocol!
    var viewController: ScannerFlowViewController!

    override func setUp() {
        viewModel = ScannerFlowViewModelMock()
        customView = ScannerFlowView.make()
        viewController = ScannerFlowViewController(customView: customView, viewModel: viewModel)
    }

    func testScannerFlowViewModel() throws {
        viewModel.setup(viewController)
        let imagePath = Bundle.module.url(forResource: "IDENTIDADE", withExtension: "jpeg")!.path
        let image = UIImage(contentsOfFile: imagePath)!.cgImage!
        viewController.perfomRecognizeTextRequest(image: image)

        XCTAssertTrue(viewModel.setupWasCalled)
    }
}
