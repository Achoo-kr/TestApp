//
//  SceneDelegate.swift
//  TestApp
//
//  Created by 추현호 on 2023/08/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        print("Scene")
        print(scene.debugDescription)

        print(session.debugDescription)

        print(connectionOptions.debugDescription)

        guard let _ = (scene as? UIWindowScene) else { return }

    }

    func sceneDidDisconnect(_ scene: UIScene) {

        print(scene.debugDescription)

    }

    func sceneDidBecomeActive(_ scene: UIScene) {

        print(scene.debugDescription)

    }

    func sceneWillResignActive(_ scene: UIScene) {
      
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
      
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
      
    }
}
