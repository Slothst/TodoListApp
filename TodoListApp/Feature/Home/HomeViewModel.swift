//
//  HomeViewModel.swift
//  TodoListApp
//
//  Created by 최낙주 on 2/24/25.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var selectedTab: Tab
    @Published var todosCount: Int
    @Published var memosCount: Int
    
    init(
        selectedTab: Tab = .todoList,
        todosCount: Int = 0,
        memosCount: Int = 0
    ) {
        self.selectedTab = selectedTab
        self.todosCount = todosCount
        self.memosCount = memosCount
    }
}

extension HomeViewModel {
    func setTodosCount(_ count: Int) {
        todosCount = count
    }
    
    func setMemosCount(_ count: Int) {
        memosCount = count
    }
    
    func changeSelectedTab(_ tab: Tab) {
        selectedTab = tab
    }
}
