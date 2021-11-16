import XCTest
@testable import ScannerFlow

@available(iOS 15.0, *)
final class ScannerFlowViewModelTests: XCTestCase {

    var viewModel: ScannerFlowViewModelProtocol!
    var viewController: ScannerFlowViewControllerMock!

    override func setUp() {
        viewModel = ScannerFlowViewModel()
        viewController = ScannerFlowViewControllerMock()
    }

    func testScannerFlowViewModel_givenIDImageWithIdealProperties_shouldRenderImageName() throws {
        viewModel.setup(viewController)
        let imagePath = Bundle.module.url(forResource: "IDENTIDADE", withExtension: "jpeg")!.path
        let image = UIImage(contentsOfFile: imagePath)!.cgImage!
        viewModel.performRequest(from: image)

        XCTAssertEqual(viewController.renderCalledWithName, ScannerFlow.DataSource.mock().recognizedName)
    }
}
