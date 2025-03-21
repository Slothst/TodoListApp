//
//  TodoListViewModel.swift
//  TodoListApp
//
//  Created by 최낙주 on 2/26/25.
//

import UIKit
import CoreData

class TodoListViewModel: ViewModel {
    @Published var todos: [Todo]
    @Published var removeTodos: [Todo]
    @Published var isRemoveTodoAlertDisplay: Bool
    var notificationService: NotificationService
    
    var removeTodosCount: Int {
        return removeTodos.count
    }
    
    var navigationBarRightBtnMode: NavigationBtnType {
        isEditMode ? .complete : .edit
    }
    
    init(
        todos: [Todo] = TodoCoreDataManager.fetchData(),
        removeTodos: [Todo] = [],
        isRemoveTodoAlertDisplay: Bool = false,
        notificationService: NotificationService = .init()
    ) {
        self.todos = todos
        self.removeTodos = removeTodos
        self.isRemoveTodoAlertDisplay = isRemoveTodoAlertDisplay
        self.notificationService = notificationService
    }
}

extension TodoListViewModel {
    func selectedBoxTapped(_ todo: Todo) {
        if let index = todos.firstIndex(where: { $0 == todo }) {
            todos[index].selected.toggle()
//            notificationService.printPendingNotification()
        }
    }
    
    func addTodo(_ todo: Todo) {
        TodoCoreDataManager.saveData(todo)
        notificationService.sendTodoNotification(todo)
        todos = TodoCoreDataManager.fetchData()
    }
    
    func navigationRightBtnTapped() {
        if isEditMode {
            if removeTodos.isEmpty {
                isEditMode = false
            } else {
                setIsRemoveTodoAlertDisplay(true)
            }
        } else {
            isEditMode = true
        }
    }
    
    func setIsRemoveTodoAlertDisplay(_ isDisplay: Bool) {
        isRemoveTodoAlertDisplay = isDisplay
    }
    
    func removeSelectedTodos(_ todo: Todo) {
        if let index = removeTodos.firstIndex(of: todo) {
            removeTodos.remove(at: index)
        } else {
            removeTodos.append(todo)
        }
    }
    
    func removeBtnTapped() {
        removeTodos.forEach { todo in
            TodoCoreDataManager.deleteData(todo)
        }
        removeTodos.removeAll()
        isEditMode = false
        todos = TodoCoreDataManager.fetchData()
    }
}
