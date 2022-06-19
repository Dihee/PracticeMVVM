//
//  ViewController.swift
//  PracticeMVVM
//
//  Created by Jihee hwang on 2022/06/16.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    let viewModel = ViewModel()
    
    private let verticalStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let horizontalStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 15
        return stackView
    }()
    
    private var datetimeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private var yesterday: DateButton = {
        let button = DateButton()
        button.setTitle("어제", for: .normal)
        return button
    }()
    
    private var now: DateButton = {
        let button = DateButton()
        button.setTitle("오늘", for: .normal)
        return button
    }()
    
    private var tommorow: DateButton = {
        let button = DateButton()
        button.setTitle("내일", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        viewModel.viewDidLoad()
        viewModel.onUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.datetimeLabel.text = self?.viewModel.dataTimeString
            }
        }
        buttonAddTargerts()
        layout()
    }
    
    private func buttonAddTargerts() {
        now.addTarget(nil, action: #selector(viewModel.viewDidLoad), for: .touchUpInside)
        tommorow.addTarget(nil, action: #selector(viewModel.moveDay(day:)), for: .touchUpInside)
        yesterday.addTarget(nil, action: #selector(viewModel.moveDay(day:)), for: .touchUpInside)
    }
    
    private func layout() {
        view.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(datetimeLabel)
        verticalStackView.addArrangedSubview(horizontalStackView)
        
        horizontalStackView.addArrangedSubview(yesterday)
        horizontalStackView.addArrangedSubview(now)
        horizontalStackView.addArrangedSubview(tommorow)

        verticalStackView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
}
   
