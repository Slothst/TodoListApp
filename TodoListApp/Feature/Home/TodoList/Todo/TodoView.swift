//
//  TodoView.swift
//  TodoListApp
//
//  Created by 최낙주 on 2/26/25.
//

import SwiftUI

struct TodoView: View {
    @EnvironmentObject private var pathModel: PathModel
    @EnvironmentObject private var todoListViewModel: TodoListViewModel
    @StateObject private var todoViewModel: TodoViewModel = TodoViewModel()
    
    var body: some View {
        VStack {
            CustomNavigationBar(
                leftBtnAction: {
                    pathModel.paths.removeLast()
                },
                rightBtnAction: {
                    todoListViewModel.addTodo(
                        .init(
                            uuid: UUID(),
                            title: todoViewModel.title,
                            time: todoViewModel.time,
                            day: todoViewModel.day,
                            selected: false
                        )
                    )
                    pathModel.paths.removeLast()
                },
                rightBtnType: .create
            )
            
            TitleView()
                .padding(.top, 20)
            
            Spacer()
                .frame(height: 20)
            
            TodoTitleView(todoViewModel: todoViewModel)
                .padding(.horizontal, 20)
            
            SelectTimeView(todoViewModel: todoViewModel)
            
            SelectDayView(todoViewModel: todoViewModel)
                .padding(.horizontal, 20)
            
            Spacer()
            
        }
    }
}

private struct TitleView: View {
    fileprivate var body: some View {
        HStack {
            Text("Add your own\nTo do list!")
            
            Spacer()
        }
        .font(.system(size: 30, weight: .bold))
        .padding(.leading, 20)
    }
}

private struct TodoTitleView: View {
    @ObservedObject private var todoViewModel: TodoViewModel
    
    fileprivate init(todoViewModel: TodoViewModel) {
        self.todoViewModel = todoViewModel
    }
    fileprivate var body: some View {
        TextField("Insert your To do...", text: $todoViewModel.title)
    }
}

private struct SelectTimeView: View {
    @ObservedObject private var todoViewModel: TodoViewModel
    
    fileprivate init(todoViewModel: TodoViewModel) {
        self.todoViewModel = todoViewModel
    }
    
    fileprivate var body: some View {
        Rectangle()
            .fill(Color.gray.opacity(0.5))
            .frame(height: 1)
        
        DatePicker(
            "",
            selection: $todoViewModel.time,
            displayedComponents: [.hourAndMinute]
        )
        .labelsHidden()
        .datePickerStyle(WheelDatePickerStyle())
        .frame(maxWidth: .infinity, alignment: .center)
        
        Rectangle()
            .fill(Color.gray.opacity(0.5))
            .frame(height: 1)
    }
}

private struct SelectDayView: View {
    @ObservedObject private var todoViewModel: TodoViewModel
    
    fileprivate init(todoViewModel: TodoViewModel) {
        self.todoViewModel = todoViewModel
    }
    
    fileprivate var body: some View {
        VStack(spacing: 5) {
            HStack {
                Text("Day")
                    .foregroundStyle(Color.gray)
                
                Spacer()
            }
            
            HStack {
                Button {
                    todoViewModel.setIsCalendarDisplay(true)
                } label: {
                    Text("\(todoViewModel.day.formattedDay)")
                        .font(.system(size: 18, weight: .medium))
                        .tint(Color.orange)
                }
                .popover(isPresented: $todoViewModel.isCalendarDisplay) {
                    DatePicker(
                        "",
                        selection: $todoViewModel.day,
                        displayedComponents: .date
                    )
                    .labelsHidden()
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()
                    .onChange(of: todoViewModel.day) { _ in
                        todoViewModel.setIsCalendarDisplay(false)
                    }
                }
                
                Spacer()
            }
        }
    }
}

struct TodoView_Previews: PreviewProvider {
    static var previews: some View {
        TodoView()
    }
}
