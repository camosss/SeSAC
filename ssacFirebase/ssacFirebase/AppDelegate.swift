//
//  AppDelegate.swift
//  ssacFirebase
//
//  Created by 강호성 on 2021/12/06.
//

import UIKit
import Firebase
import AppTrackingTransparency
import FirebaseMessaging

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // firebase 초기화, 공유 인스턴스 생성
        FirebaseApp.configure()
        
        // 원격 알림 등록 (권한)
        // For iOS 10 display notification (sent via APNS)
        UNUserNotificationCenter.current().delegate = self
        
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { _, _ in }
        )
        application.registerForRemoteNotifications()
        
        // Firebase가 메시지를 대신 전송할 수 있도록 대리자 설정
        Messaging.messaging().delegate = self
        
        // 현재 등록 토큰 가져오기
        Messaging.messaging().token { token, error in
            if let error = error {
                print("Error fetching FCM registration token: \(error)")
            } else if let token = token {
                print("FCM registration token: \(token)")
            }
        }
        
        return true
    }

    // MARK: - UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

}

// MARK: - UNUserNotificationCenterDelegate

extension AppDelegate: UNUserNotificationCenterDelegate {
    // 재구성 사용 중지됨: APN 토큰과 등록 토큰 매핑
    func application(application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
    // foreground 수신: willPresent(로컬/푸시 동일)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        guard let rootViewController = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController?.topViewController else { return }
        
        if rootViewController is ViewController {
            completionHandler([])
        } else {
            completionHandler([.list, .banner, .badge, .sound])
        }
    }
    
    // push를 클릭했을 때의 이벤트 (기본으로는 앱이꺼져있을 때, 앱을 켜주는 정도)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("사용자가 푸시를 클릭했습니다.")
        
        // userInfo: key - 1(광고), 2(채팅방), 3(사용자 설정)
        print(response.notification.request.content.userInfo)
        print(response.notification.request.content.body)
        
        let userInfo = response.notification.request.content.userInfo
        
        if userInfo[AnyHashable("key")] as? Int == 1 {
            print("광고 푸시입니다.")
        } else {
            print("다른 푸시입니다.")
        }
        
        // SceneDelegate의 Window 객체 가져오기
        guard let rootViewController = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController?.topViewController else { return }
        print(rootViewController) // TabBarController
        
        if rootViewController is SecondViewController {
            rootViewController.navigationController?.pushViewController(SecondViewController(), animated: true)
        }
        
        completionHandler()
    }
}

// MARK: - 최상단 ViewController를 판단해주는 UIViewController Extension

extension UIViewController {
    var topViewController: UIViewController? {
        return self.topViewController(currentViewController: self)
    }
    // currentViewController: TabBarController
    func topViewController(currentViewController: UIViewController) -> UIViewController {
        if let tabBarController = currentViewController as? UITabBarController,
           let selectedViewController = tabBarController.selectedViewController {
            return self.topViewController(currentViewController: selectedViewController)
            
        } else if let navigationController = currentViewController as? UINavigationController,
                  let visibleViewController = navigationController.visibleViewController {
            return self.topViewController(currentViewController: visibleViewController)
            
        } else if let presentViewController = currentViewController.presentedViewController {
            return self.topViewController(currentViewController: presentViewController)
            
        } else {
            return currentViewController
        }
    }
}

// MARK: - MessagingDelegate

extension AppDelegate: MessagingDelegate {
    // 토큰 갱신 모니터링
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase registration token: \(String(describing: fcmToken))")
        
        let dataDict: [String: String] = ["token": fcmToken ?? ""]
        NotificationCenter.default.post(
            name: Notification.Name("FCMToken"),
            object: nil,
            userInfo: dataDict
        )
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
}
