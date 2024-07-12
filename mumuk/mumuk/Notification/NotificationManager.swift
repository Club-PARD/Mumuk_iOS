//import UserNotifications
//
//class NotificationManager {
//    static let shared = NotificationManager()
//    
//    private init() {}
//    
//    func requestAuthorization() {
//        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
//            if granted {
//                print("알림 권한이 허용되었습니다.")
//            } else {
//                print("알림 권한이 거부되었습니다.")
//            }
//        }
//    }
//    
//    func scheduleNotification(for uid: String) {
//        let content = UNMutableNotificationContent()
//        content.title = "입맛 입력 알림"
//        content.body = "오늘의 입맛을 입력해주세요!"
//        content.sound = .default
//        
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
//        
//        let request = UNNotificationRequest(identifier: uid, content: content, trigger: trigger)
//        
//        UNUserNotificationCenter.current().add(request) { error in
//            if let error = error {
//                print("알림 스케줄링 오류: \(error)")
//            }
//        }
//    }
//}
