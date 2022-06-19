//
//  Service.swift
//  PracticeMVVM
//
//  Created by Jihee hwang on 2022/06/19.
//

import Foundation

// MARK: Service가 Repository로 부터 Entity를 받음

final class Service {
    let repo = Repository()
    var currentModel = Model(currentDateTime: Date())
    
    // Entity를 Model로 변경
    func fetchNow(onComplited: @escaping(Model) -> Void) {
        repo.fetchNow { entity in
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm'Z'"
            
            guard let now = formatter.date(from: entity.currentDateTime) else { return }
            let model = Model(currentDateTime: now)
            self.currentModel = model
            onComplited(model)
        }
    }
    
    func moveDay(day: Int) {
        guard let movedDay = Calendar.current.date(byAdding: .day, value: day, to: currentModel.currentDateTime) else { return }
        currentModel.currentDateTime = movedDay
    }
    
}
