//
//  ScannerFlowView.swift
//  ScannerFlow
//
//  Created by Filipe da Cruz Ribeiro on 12/11/21.
//

import Foundation
import UIKit

protocol ScannerFlowViewProtocol where Self: UIView  {
    func setup(_ delegate: ScannerFlowViewDelegate)
}

protocol ScannerFlowViewDelegate: AnyObject {
    func openCamera()
}

final class ScannerFlowView: UIView {

    private weak var delegate: ScannerFlowViewDelegate?

    static func make() -> ScannerFlowViewProtocol {
        ScannerFlowView()
    }

    private let takePictureButton: UIButton = {
        let button = UIButton()
        button.setTitle("Take card picture", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    private func setup() {
        backgroundColor = .white
        setupTakePictureButton()
    }

    private func setupTakePictureButton() {
        addSubview(takePictureButton)

        takePictureButton.translatesAutoresizingMaskIntoConstraints = false

        takePictureButton.translatesAutoresizingMaskIntoConstraints = false
        takePictureButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        takePictureButton.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        takePictureButton.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true

        takePictureButton.addTarget(self, action: #selector(openCamera), for: .touchUpInside)
    }

    @objc private func openCamera() {
        delegate?.openCamera()
    }
}

extension ScannerFlowView: ScannerFlowViewProtocol {
    func setup(_ delegate: ScannerFlowViewDelegate) {
        self.delegate = delegate
    }
}
