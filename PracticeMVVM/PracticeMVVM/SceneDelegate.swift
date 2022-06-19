//
//  SceneDelegate.swift
//  PracticeMVVM
//
//  Created by Jihee hwang on 2022/06/16.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let mainVC = ViewController()
        window?.rootViewController = mainVC
        window?.makeKeyAndVisible()
        
        // 윈도우 신을 윈도우에 넣어주고, 메인 뷰컨을 윈도우 루트뷰로 설정, makeKeyAndVisible
    }

}

