//
//  ViewController.swift
//  PracticeMVVM
//
//  Created by Jihee hwang on 2022/06/16.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    private var currentDateTime = Date()
    
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
        button.addTarget(nil, action: #selector(fetchYesterday), for: .touchUpInside)
        return button
    }()
    
    private var now: DateButton = {
        let button = DateButton()
        button.setTitle("오늘", for: .normal)
        button.addTarget(nil, action: #selector(fetchNow), for: .touchUpInside)
        return button
    }()
    
    private var tommorow: DateButton = {
        let button = DateButton()
        button.setTitle("내일", for: .normal)
        button.addTarget(nil, action: #selector(fetchTomorrow), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        layout()
        fetchNow()
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
    
    private func updateDateTime() {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy년 MM월 dd일 HH시 mm분"
            datetimeLabel.text = formatter.string(from: currentDateTime)
    }
    
    // MARK: - @objc
    
    @objc private func fetchNow() {
        let url = "http://worldclockapi.com/api/json/utc/now"
        datetimeLabel.text = "Loding..."
        
        URLSession.shared.dataTask(with: URL(string:url)!) { [weak self] data, _, _ in
            guard let data = data else { return }
            guard let model = try? JSONDecoder().decode(UTcTimeModel.self, from: data) else { return }
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm'Z'"
            
            guard let now = formatter.date(from: model.currentDateTime) else { return }
            self?.currentDateTime = now
            
            DispatchQueue.main.async {
                self?.updateDateTime()
            }
        }.resume()
    }
    
    @objc private func fetchYesterday() {
        guard let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: currentDateTime) else { return }
        currentDateTime = yesterday
        
        DispatchQueue.main.async {
            self.updateDateTime()
        }
    }
    
    @objc private func fetchTomorrow() {
        guard let tomorrow = Calendar.current.date(byAdding: .day, value: +1, to: currentDateTime) else { return }
        currentDateTime = tomorrow
        
        DispatchQueue.main.async {
            self.updateDateTime()
        }
    }
   
    
    // MARK: - Model
    struct UTcTimeModel: Codable {
        let currentDateTime: String
    }
}

