//
//  AppDelegate.swift
//  mumuk
//
//  Created by 김현중 on 6/19/24.
//

import UIKit

import KakaoSDKCommon
import KakaoSDKAuth
import UserNotifications


@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    
    
    
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        KakaoSDK.initSDK(appKey: "1e6b5167b05b0aaf5f1873503dcf2af3")

        //이 부분을 추가해서 일단 앱을 키면 삭제된 기록 지우고 default값으로 되돌리려고 합니다. 이건 ExampleModelData의  resetToDefault 함수를 실행시키는 것이다.
            ExampleModelData.resetToDefault()
        
        //앱이 켜져있을 때 알림 허용하는 delegate
        UNUserNotificationCenter.current().delegate = self
        
        let window = UIWindow(frame: UIScreen.main.bounds)
//
//        let initialViewController = PreferViewController1() // 여기에 시작하려는 뷰 컨트롤러를 넣으세요
//        let navigationController = UINavigationController(rootViewController: initialViewController)
//        
//        window.rootViewController = navigationController
//        window.makeKeyAndVisible()
        
        
        
        // 알림 권한 요청
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            if let error = error {
                print("알림 권한 요청 오류: \(error.localizedDescription)")
            }
        }
        
        // 기본 폰트 크기
            let defaultSize: CGFloat = 17
            
            // 기본 폰트 설정
            UILabel.appearance().font = .pretendard(.regular, size: defaultSize)
            UITextField.appearance().font = .pretendard(.regular, size: defaultSize)
            UITextView.appearance().font = .pretendard(.regular, size: defaultSize)
            UIButton.appearance().titleLabel?.font = .pretendard(.regular, size: defaultSize)
            
            // 네비게이션 바 타이틀 폰트
            UINavigationBar.appearance().titleTextAttributes = [.font: UIFont.pretendard(.bold, size: defaultSize + 2)]

        return true
    }

    // MARK: UISceneSession Lifecycle

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


    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
           if (AuthApi.isKakaoTalkLoginUrl(url)) {
               return AuthController.handleOpenUrl(url: url)
           }
           return false
       }

    // 앱이 foreground상태 (켰을 때)에서 알림을 수신했을 때 호출되는 메서드
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // 알림을 표시하기 위해 completionHandler를 호출
        completionHandler([.list, .banner, .sound])
    }
    

}

