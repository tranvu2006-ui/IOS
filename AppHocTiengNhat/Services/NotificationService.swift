//
//  NotificationService.swift
//  AppHocTiengNhat
//

import Foundation
import UserNotifications

public final class NotificationService {
    public static let shared = NotificationService()
    
    private init() {}
    
    /// Yêu cầu cấp quyền gửi thông báo từ người dùng
    public func requestAuthorization(completion: ((Bool) -> Void)? = nil) {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Lỗi yêu cầu quyền thông báo: \(error.localizedDescription)")
                }
                if granted {
                    self.scheduleDailyReminder()
                }
                completion?(granted)
            }
        }
    }
    
    /// Hẹn giờ thông báo học tập lặp lại mỗi ngày lúc 20:00 (8:00 tối)
    public func scheduleDailyReminder(hour: Int = 20, minute: Int = 0) {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: ["DailyStudyReminder"])
        
        let content = UNMutableNotificationContent()
        content.title = "Đã đến giờ học tiếng Nhật! 🔥"
        content.body = "Dành 5 phút luyện tập Flashcard và Trắc nghiệm để duy trì chuỗi Streak nhé!"
        content.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: "DailyStudyReminder", content: content, trigger: trigger)
        
        center.add(request) { error in
            if let error = error {
                print("Lỗi lên lịch thông báo: \(error)")
            } else {
                print("Đã lên lịch thông báo học tập lúc \(hour):\(minute) mỗi ngày.")
            }
        }
    }
    
    /// Bắn thông báo thử nghiệm sau 3 giây để người dùng kiểm tra ngay
    public func sendTestNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Tiếng Nhật N5 - Thông báo thử nghiệm! 🔔"
        content.body = "Hệ thống nhắc nhở học tập đang hoạt động hoàn hảo!"
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        let request = UNNotificationRequest(identifier: "TestNotification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
}
