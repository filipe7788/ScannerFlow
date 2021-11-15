//
//  ScannerFlowView.swift
//  ScannerFlow
//
//  Created by Filipe da Cruz Ribeiro on 12/11/21.
//

import Foundation
import UIKit
import Cartography

protocol ScannerFlowViewProtocol where Self: UIView  {
    func render(_ dataSource: ScannerFlow.DataSource.UserInfo)
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

    private let nameStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        return stackView
    }()

    private let nameTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Recognized name:"
        label.textColor = .black
        return label
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()

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
        setupNameStackView()
        setupButton()
    }

    private func setupNameStackView() {
        addSubview(nameStackView)
        constrain(nameStackView, self) { stackView, superview in
            stackView.top == superview.centerY - 64
            stackView.leading == superview.leading + 24
            stackView.trailing == superview.trailing - 24
        }
        setupNameTitleLabel()
        setupNameLabel()
    }

    private func setupNameTitleLabel() {
        nameStackView.addArrangedSubview(nameTitleLabel)
    }

    private func setupNameLabel() {
        nameStackView.addArrangedSubview(nameLabel)
    }

    private func setupButton() {
        addSubview(takePictureButton)
        constrain(takePictureButton, nameStackView, self) { cameraButton, stackView, superview in
            cameraButton.height == 40
            cameraButton.top == stackView.bottom + 48
            cameraButton.leading == superview.leading + 24
            cameraButton.trailing == superview.trailing - 24
        }
        takePictureButton.addTarget(self, action: #selector(openCamera), for: .touchUpInside)
    }

    @objc private func openCamera() {
        delegate?.openCamera()
    }
}

extension ScannerFlowView: ScannerFlowViewProtocol {
    func render(_ dataSource: ScannerFlow.DataSource.UserInfo) {
        nameLabel.text = dataSource.recognizedName
    }

    func setup(_ delegate: ScannerFlowViewDelegate) {
        self.delegate = delegate
    }
}
