//
//  TodoListAppApp.swift
//  TodoListApp
//
//  Created by 최낙주 on 2/21/25.
//

import SwiftUI

@main
struct TodoListAppApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(TodoListViewModel())
        }
    }
}
