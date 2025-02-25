//
//  HomeViewModel.swift
//  TodoListApp
//
//  Created by 최낙주 on 2/24/25.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var selectedTab: Tab
    
    init(selectedTab: Tab = .todoList) {
        self.selectedTab = selectedTab
    }
}
