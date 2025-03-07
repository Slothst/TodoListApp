//
//  AppDelegate.swift
//  TodoListApp
//
//  Created by 최낙주 on 3/6/25.
//

import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    var notificationDelegate = NotificationDelegate()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        
        UNUserNotificationCenter.current().delegate = notificationDelegate
        
//        // 예약 알림 설정
//        let triggerDate = Calendar.current.date(byAdding: .minute, value: 1, to: Date())! // 예: 현재로부터 5분 후
//        NotificationService().sendNotification(triggerDate)
        
        return true
    }
}
