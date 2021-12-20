//
//  SceneDelegate.swift
//  ssacFirebase
//
//  Created by 강호성 on 2021/12/06.
//

import UIKit
import Firebase
import AppTrackingTransparency

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        
        window?.rootViewController = TabBarController()
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        
        // 1초 뒤 ATT Framework 권한 체크
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // ATT Framework
            ATTrackingManager.requestTrackingAuthorization { status in
                switch status {
                case .notDetermined:
                    print("notDetermined")
                    Analytics.setAnalyticsCollectionEnabled(false)
                case .restricted:
                    print("restricted")
                    Analytics.setAnalyticsCollectionEnabled(false)
                case .denied:
                    print("denied")
                    Analytics.setAnalyticsCollectionEnabled(false)
                case .authorized: // Analytics 수집 가능
                    print("authorized")
                    Analytics.setAnalyticsCollectionEnabled(true)
                @unknown default:
                    print("unknown")
                    Analytics.setAnalyticsCollectionEnabled(false)
                }
            }
        }
        
    }

    func sceneWillResignActive(_ scene: UIScene) {
        
    }

    // badge 없애기
    func sceneWillEnterForeground(_ scene: UIScene) {
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UIApplication.shared.applicationIconBadgeNumber = 0
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        
    }


}

