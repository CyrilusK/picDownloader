//
//  NotificationManager.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 07.08.2024.
//

import UIKit
import UserNotifications

final class NotificationManager {
    let center = UNUserNotificationCenter.current()
    
    func requestPermission() {
        
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            guard granted else { return }
            
            self.center.getNotificationSettings { settings in
                print("[DEBUG] - \(settings)")
                guard settings.authorizationStatus == .authorized else { return }
            }
        }
    }
    
    func scheduleDownloadSuccessNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Скачивание завершено"
        content.body = "Картинка успешно скачана"
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
        let request = UNNotificationRequest(identifier: Constants.downloadSuccess, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("[DEBUG] - Ошибка при добавлении уведомления: \(error.localizedDescription)")
            }
            else {
                NotificationCenter.default.post(name: .imageDownloaded, object: nil)
            }
        }
    }
    
    func scheduleDailyReminderNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Картинки скучают по Вас 😓"
        content.body = "Заходите в приложение и смело скачивайте новые картинки"
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60 * 60 * 24, repeats: true)
        let request = UNNotificationRequest(identifier: Constants.dailyReminder, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Ошибка при добавлении уведомления: \(error.localizedDescription)")
            }
        }
    }
    
    func removeScheduledNotification() {
        center.removePendingNotificationRequests(withIdentifiers: [Constants.dailyReminder])
    }
}

