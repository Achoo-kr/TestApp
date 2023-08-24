//
//  TestAppApp.swift
//  TestApp
//
//  Created by 추현호 on 2023/08/12.
//

import SwiftUI
import UIKit

@main
struct TestAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
//            ContentView()
            MapView()
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        return true

    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {

        if (connectingSceneSession.role == UISceneSession.Role.carTemplateApplication) {

            let scene =  UISceneConfiguration(name: "CarPlay", sessionRole: connectingSceneSession.role)

            scene.delegateClass = CarPlaySceneDelegate.self

            return scene

        } else {

            return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)

        }

    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {

    }

}
