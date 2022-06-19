//
//  Repository.swift
//  PracticeMVVM
//
//  Created by Jihee hwang on 2022/06/19.
//

import Foundation

// MARK: 서버에서 받은 JSON을 Entity로 변환 -> 이걸 Service가 받음

final class Repository {
    func fetchNow(onComplited: @escaping(Entity) -> Void) {
        let url = "http://worldclockapi.com/api/json/utc/now"

        URLSession.shared.dataTask(with: URL(string:url)!) { [weak self] data, _, _ in
            guard let data = data else { return }
            guard let model = try? JSONDecoder().decode(Entity.self, from: data) else { return }
            
            onComplited(model)
        }.resume()
    }
}
