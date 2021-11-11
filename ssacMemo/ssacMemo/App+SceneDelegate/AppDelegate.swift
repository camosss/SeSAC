//
//  AppDelegate.swift
//  ssacMemo
//
//  Created by 강호성 on 2021/11/08.
//

import UIKit

// 앱 처음 실행 때 팝업화면 띄우기: https://medium.com/swlh/how-to-detect-app-first-time-launch-2dbeece7cc7b

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var hasAlreadyLaunched: Bool!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        hasAlreadyLaunched = UserDefaults.standard.bool(forKey: "hasAlreadyLaunched")

        hasAlreadyLaunched ? hasAlreadyLaunched = true : UserDefaults.standard.set(true, forKey: "hasAlreadyLaunched")
        
        return true
    }
    
    func sethasAlreadyLaunched() {
        hasAlreadyLaunched = true
    }
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {

    }
}
