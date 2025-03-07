//
//  TodoListViewModel.swift
//  TodoListApp
//
//  Created by 최낙주 on 2/26/25.
//

import Foundation

class TodoListViewModel: ObservableObject {
    @Published var todos: [Todo]
    @Published var isEditTodoMode: Bool
    @Published var removeTodos: [Todo]
    @Published var isRemoveTodoAlertDisplay: Bool
    var notificationService: NotificationService
    
    var removeTodosCount: Int {
        return removeTodos.count
    }
    
    var navigationBarRightBtnMode: NavigationBtnType {
        isEditTodoMode ? .complete : .edit
    }
    
    init(
        todos: [Todo] = [],
        isEditTodoMode: Bool = false,
        removeTodos: [Todo] = [],
        isRemoveTodoAlertDisplay: Bool = false,
        notificationService: NotificationService = .init()
    ) {
        self.todos = todos
        self.isEditTodoMode = isEditTodoMode
        self.removeTodos = removeTodos
        self.isRemoveTodoAlertDisplay = isRemoveTodoAlertDisplay
        self.notificationService = notificationService
    }
}

extension TodoListViewModel {
    func selectedBoxTapped(_ todo: Todo) {
        if let index = todos.firstIndex(where: { $0 == todo }) {
            todos[index].selected.toggle()
            notificationService.printPendingNotification()
        }
    }
    
    func addTodo(_ todo: Todo) {
        todos.append(todo)
        notificationService.sendTodoNotification(todo)
    }
    
    func navigationRightBtnTapped() {
        if isEditTodoMode {
            if removeTodos.isEmpty {
                isEditTodoMode = false
            } else {
                setIsRemoveTodoAlertDisplay(true)
            }
        } else {
            isEditTodoMode = true
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
        todos.removeAll { todo in
            removeTodos.contains(todo)
        }
        removeTodos.removeAll()
        isEditTodoMode = false
    }
}
