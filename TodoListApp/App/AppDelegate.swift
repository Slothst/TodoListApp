//
//  AppDelegate.swift
//  TodoListApp
//
//  Created by 최낙주 on 3/6/25.
//

import UIKit
import CoreData

class AppDelegate: NSObject, UIApplicationDelegate, ObservableObject {
    
    // MARK: - Core Data Stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TodoListApp")
        container.loadPersistentStores(
            completionHandler: { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var notificationDelegate = NotificationDelegate()
    
    // MARK: - Core Data Saving Support
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        
        UNUserNotificationCenter.current().delegate = notificationDelegate
        
//        // 예약 알림 설정
//        let triggerDate = Calendar.current.date(byAdding: .minute, value: 1, to: Date())! // 예: 현재로부터 5분 후
//        NotificationService().sendNotification(triggerDate)
        
        return true
    }
}
