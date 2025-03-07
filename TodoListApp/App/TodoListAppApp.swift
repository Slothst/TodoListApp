//
//  TodoListAppApp.swift
//  TodoListApp
//
//  Created by 최낙주 on 2/21/25.
//

import SwiftUI

@main
struct TodoListAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(PathModel())
                .environmentObject(TodoListViewModel())
                .environmentObject(MemoListViewModel())
        }
    }
}
