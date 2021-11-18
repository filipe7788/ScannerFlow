import XCTest
@testable import ScannerFlow

@available(iOS 13.0, *)
final class ScannerFlowViewModelTests: XCTestCase {

    var viewModel: ScannerFlowViewModelProtocol!
    var viewController: ScannerFlowViewControllerMock!

    override func setUp() {
        viewModel = ScannerFlowViewModel()
        viewController = ScannerFlowViewControllerMock()
        viewModel.setup(viewController)
    }

    func testScannerFlowViewModel_givenIDImageWithIdealProperties_shouldRenderImageName() throws {
        let imagePath = Bundle.module.url(forResource: "IDENTIDADE", withExtension: "jpeg")!.path
        let image = UIImage(contentsOfFile: imagePath)!.cgImage!
        viewModel.performRequest(from: image)

        XCTAssertEqual(viewController.renderCalledWithName, ScannerFlow.DataSource.mock().recognizedText)
    }
}
