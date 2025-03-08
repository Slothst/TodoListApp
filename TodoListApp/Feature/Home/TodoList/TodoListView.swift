//
//  TodoListView.swift
//  TodoListApp
//
//  Created by 최낙주 on 2/24/25.
//

import SwiftUI

struct TodoListView: View {
    @EnvironmentObject private var pathModel: PathModel
    @EnvironmentObject private var todoListViewModel: TodoListViewModel
    @EnvironmentObject private var homeViewModel: HomeViewModel
    
    var body: some View {
        WriteBtnView(content: {
            VStack {
                if !todoListViewModel.todos.isEmpty {
                    CustomNavigationBar(
                        isLeftBtnDisplay: false,
                        rightBtnAction: {
                            todoListViewModel.navigationRightBtnTapped()
                        },
                        rightBtnType: todoListViewModel.navigationBarRightBtnMode
                    )
                } else {
                    Spacer()
                        .frame(height: 30)
                }
                
                TitleView()
                    .padding(.top, 30)
                if todoListViewModel.todos.isEmpty {
                    AnnouncementView()
                } else {
                    TodoListContentView()
                        .padding(.top, 20)
                }
            }
        }, action: {
            pathModel.paths.append(.todoView)
        }, viewModel: todoListViewModel)
        .alert(
            todoListViewModel.removeTodosCount == 1
            ? "Are you sure to delete \(todoListViewModel.removeTodosCount) To do List?"
            : "Are you sure to delete \(todoListViewModel.removeTodosCount) To do Lists?",
            isPresented: $todoListViewModel.isRemoveTodoAlertDisplay
        ) {
            Button("Delete", role: .destructive) {
                todoListViewModel.removeBtnTapped()
            }
            
            Button("Cancel", role: .cancel) { }
        }
        .onChange(
            of: todoListViewModel.todos,
            perform: { todos in
                homeViewModel.setTodosCount(todos.count)
            }
        )
    }
}

private struct TitleView: View {
    @EnvironmentObject private var todoListViewModel: TodoListViewModel
    fileprivate var body: some View {
        HStack {
            if todoListViewModel.todos.isEmpty {
                Text("Add your own\nTo do list!")
            } else {
                if todoListViewModel.todos.count == 1 {
                    Text("You have \(todoListViewModel.todos.count) To do list")
                } else {
                    Text("You have \(todoListViewModel.todos.count) To do lists")
                }
            }
            
            Spacer()
        }
        .font(.system(size: 30, weight: .bold))
        .padding(.leading, 20)
    }
}

private struct AnnouncementView: View {
    fileprivate var body: some View {
        VStack(spacing: 15) {
            Spacer()
            
            Image(systemName: "square.and.pencil")
                .font(.system(size: 30))
                
            Text("\"Go to gym\"")
            Text("\"Do some homework\"")
            Text("\"Watch Netflix\"")
            
            Spacer()
        }
        .font(.system(size: 16))
        .foregroundStyle(.secondary)
    }
}

private struct TodoListContentView: View {
    @EnvironmentObject private var todoListViewModel: TodoListViewModel
    
    fileprivate var body: some View {
        VStack {
            HStack {
                Text("To do List")
                    .font(.system(size: 16, weight: .bold))
                    .padding(.leading, 20)
                
                Spacer()
            }
            
            ScrollView(.vertical) {
                VStack(spacing: 0) {
                    Rectangle()
                        .fill(Color.gray.opacity(0.5))
                        .frame(height: 1)
                    
                    ForEach(todoListViewModel.todos, id: \.self) { todo in
                        TodoCellView(todo: todo)
                    }
                }
            }
        }
    }
}

private struct TodoCellView: View {
    @EnvironmentObject private var todoListViewModel: TodoListViewModel
    @State private var isSelected: Bool
    private var todo: Todo
    
    fileprivate init(
        isSelected: Bool = false,
        todo: Todo
    ) {
        _isSelected = State(initialValue: isSelected)
        self.todo = todo
    }
    
    fileprivate var body: some View {
        VStack(spacing: 20) {
            HStack {
                if !todoListViewModel.isEditMode {
                    Button {
                        todoListViewModel.selectedBoxTapped(todo)
                    } label: {
                        todo.selected ?
                        Image(systemName: "checkmark.square.fill")
                            .font(.system(size: 20)) :
                        Image(systemName: "square")
                            .font(.system(size: 20))
                    }
                }
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(todo.title)
                        .font(.system(size: 16))
                        .foregroundStyle(todo.selected ? Color.gray : Color.primary)
                        .strikethrough(todo.selected)
                    
                    Text(todo.convertedDayAndTime)
                        .font(.system(size: 16))
                        .foregroundStyle(Color.gray)
                }
                
                Spacer()
                
                if todoListViewModel.isEditMode {
                    Button {
                        isSelected.toggle()
                        todoListViewModel.removeSelectedTodos(todo)
                    } label: {
                        isSelected ?
                        Image(systemName: "checkmark.square.fill")
                            .font(.system(size: 20)) :
                        Image(systemName: "square")
                            .font(.system(size: 20))
                    }
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 10)
        
        Spacer()
        
        Rectangle()
            .fill(Color.gray.opacity(0.5))
            .frame(height: 1)
    }
}

private struct WriteTodoBtnView: View {
    @EnvironmentObject private var pathModel: PathModel
    
    fileprivate var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Spacer()
                
                Button {
                    pathModel.paths.append(.todoView)
                } label: {
                    Image(systemName: "pencil.circle.fill")
                }
                .tint(Color.orange)
            }
        }
    }
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView()
            .environmentObject(PathModel())
            .environmentObject(TodoListViewModel())
    }
}
