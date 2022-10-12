//
//  BlueViewController.swift
//  CoordinatorPatern
//
//  Created by yangjs on 2022/10/05.
//

import UIKit

class BlueViewController: UIViewController {

    static func create(tapCount: Int) -> BlueViewController {
        return BlueViewController(tapCount: tapCount)
    }

    let tapCount: Int

    init(tapCount: Int) {
        self.tapCount = tapCount
        super.init(nibName: nil, bundle: nil)

        view.backgroundColor = .blue.withAlphaComponent(0.7)
    }

    required init?(coder: NSCoder) {
        fatalError("init?(coder: NSCoder) has not been implemented")
    }

    lazy var cntLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white

        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        addSubviews()
        makeConstraints()
    }

    private func setupViews() {
        cntLabel.text = String(tapCount)
    }

    private func addSubviews() {
        view.addSubview(cntLabel)
    }

    private func makeConstraints() {
        cntLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }

}
