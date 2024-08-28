//
//  NotificationManager.swift
//  ChuckNorrisJokes
//
//  Created by Юлия Кагирова on 27.08.2024.
//

import UIKit
import UserNotifications

 
class LocalNotificationsService {
    
    private var categoryID = " category1"
    
    init() {
        registerCategory() 
    }
    
    func requestPermission() {
        Task {
            try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound])
        }
    }
    @MainActor
    func checkAuthorizationStatus() async -> Bool {
        await UNUserNotificationCenter.current().notificationSettings().authorizationStatus == .authorized
    }
    
    func addNotification() {
        let content = UNMutableNotificationContent()
        content.title = "ChuckNorrisJokes"
        content.body = "Посмотрите последние обновления"
        content.badge = 1
        content.sound = .default
        content.userInfo = ["key": "value"]
        content.categoryIdentifier = categoryID
        
        var date = DateComponents()
        date.hour = 19
        date.minute = 00
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)

        let request = UNNotificationRequest(identifier: "123", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    func resetNotification() {
//        UNUserNotificationCenter.current().removeAllPendingNotificationReq uests()
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["123"])
    }
    
    private func registerCategory () {
       let action = UNNotificationAction(identifier:  "actionID", title: "Push me!")
       let category = UNNotificationCategory(identifier: categoryID, actions: [action], intentIdentifiers: [])
        UNUserNotificationCenter.current().setNotificationCategories( [category])
    }
}