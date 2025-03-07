//
//  NotificationService.swift
//  TodoListApp
//
//  Created by 최낙주 on 3/6/25.
//

import UserNotifications

struct NotificationService {
    
    func sendTodoNotification(_ todo: Todo) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, _ in
            if granted {
                let content = UNMutableNotificationContent()
                content.title = "\(todo.title)"
                content.body = "\(todo.convertedDayAndTime)"
                
                var notificationDate = Calendar.current.dateComponents([.year, .month, .day], from: todo.day)
                notificationDate.hour = todo.time.formattedNotificationHour
                notificationDate.minute = todo.time.formattedNotificationMinute
                
                let trigger = UNCalendarNotificationTrigger(dateMatching: notificationDate, repeats: false)
                let request = UNNotificationRequest(
                    identifier: UUID().uuidString,
                    content: content,
                    trigger: trigger
                )
                
                UNUserNotificationCenter.current().add(request) { error in
                    if let error = error {
                        print("Notification Error : \(error)")
                    }
                }
            }
        }
    }
    
    func printPendingNotification() {
        UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
            for request in requests {
                print("Identifier: \(request.identifier)")
                print("Title: \(request.content.title)")
                print("Body: \(request.content.body)")
                print("Trigger: \(String(describing: request.trigger))")
                print("---")
            }
        }
    }
}

class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([.banner, .sound])
    }
}
