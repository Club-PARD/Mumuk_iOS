//
//  NotificationController.swift
//  mumuk
//
//  Created by 유재혁 on 6/28/24.
//

import UIKit
import UserNotifications

class NotificationController: UIViewController {
    public static let notificationCenter = UNUserNotificationCenter.current()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationController.requestNotificationAuthorization()
//        NotificationController.scheduleDailyNotification()
        NotificationController.scheduleNotification()

        
    }
    
//    알림 권한 요청
    static func requestNotificationAuthorization() {
        let authOptions: UNAuthorizationOptions = [.alert, .sound, .badge]

        notificationCenter.requestAuthorization(options: authOptions) { success, error in
            if let error = error {
                print(error)
            }
        }
    }
    
    
////    매일 아침 10시 알람
//    static func scheduleDailyNotification() {
//            // 알림 콘텐츠 생성
//            let content = UNMutableNotificationContent()
//            content.title = "아침 알림"
//            content.body = "좋은 아침입니다! 오늘 하루도 화이팅하세요!"
//            content.sound = UNNotificationSound.default
//            content.badge = 1
//            
//            // 매일 아침 10시에 알림을 트리거하는 트리거 생성
//            var dateComponents = DateComponents()
////            dateComponents.hour = 10
////            dateComponents.minute = 0
//            dateComponents.second = 10
//            
//            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
//            
//            let request = UNNotificationRequest(identifier: "dailyMorningNotification", content: content, trigger: trigger)
//            
//            notificationCenter.add(request) { error in
//                if let error = error {
//                    print("알림 추가 실패: \(error.localizedDescription)")
//                } else {
//                    print("알림 추가 성공")
//                }
//            }
//        }
    
//    앱 키고 5초 뒤 알람
    static  func scheduleNotification() {
            let content = UNMutableNotificationContent()
            content.title = "알림 제목입니다"
            content.body = "알림 바디입니다. 여기 내용이 들어갑니다."
            content.sound = UNNotificationSound.default
            content.badge = 1
            
            // 5초 뒤에 알림을 실행하는 트리거 생성
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            
            let request = UNNotificationRequest(identifier: "testNotification", content: content, trigger: trigger)
            
            notificationCenter.add(request) { error in
                if let error = error {
                    print("알림 추가 실패: \(error.localizedDescription)")
                } else {
                    print("알림 추가 성공")
                }
            }
        }
    
    
}
