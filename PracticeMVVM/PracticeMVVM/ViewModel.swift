//
//  ViewModel.swift
//  PracticeMVVM
//
//  Created by Jihee hwang on 2022/06/19.
//

import Foundation

final class ViewModel {
    let service = Service()
    var onUpdate: () -> Void = {}
    
    var dataTimeString = "Loding..." {
        didSet { onUpdate() } // 값이 변경된 직후에 호출
    }
    
    @objc func viewDidLoad() {
        service.fetchNow { model in
            let dataString = self.updateDateTime(date: model.currentDateTime)
            self.dataTimeString = dataString
        }
    }
    
    @objc func moveDay(day: Int) {
        service.moveDay(day: day)
        dataTimeString = updateDateTime(date: service.currentModel.currentDateTime)
    }
    
    func updateDateTime(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일 HH시 mm분"
        return formatter.string(from: date)
    }
}
