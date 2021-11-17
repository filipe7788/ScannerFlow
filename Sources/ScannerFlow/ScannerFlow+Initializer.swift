//
//  ScannerFlow+Initializer.swift
//  ScannerFlow
//
//  Created by Filipe da Cruz Ribeiro on 12/11/21.
//

import Foundation
import UIKit

@available(iOS 13.0, *)
extension ScannerFlow {
    public static func initialize(with delegate: ScannerFlowDelegate) -> UIViewController {
        let customView = ScannerFlowView.make()
        let viewModel = ScannerFlowViewModel()
        let viewController = ScannerFlowViewController(
            customView: customView,
            viewModel: viewModel,
            delegate: delegate
        )
        viewModel.setup(viewController)
        customView.setup(viewController)
        return viewController
    }
}
