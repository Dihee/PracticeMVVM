//
//  DateButton.swift
//  PracticeMVVM
//
//  Created by Jihee hwang on 2022/06/19.
//

import UIKit
import SnapKit

class DateButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configuration()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("Init with coder is unavailable")
    }

    private func configuration() {
        clipsToBounds = false
        layer.cornerRadius = 5
        backgroundColor = .darkGray
        snp.makeConstraints {
            $0.width.equalTo(90)
        }
    }
}
