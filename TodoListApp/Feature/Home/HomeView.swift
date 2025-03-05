//
//  HomeView.swift
//  TodoListApp
//
//  Created by 최낙주 on 2/21/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var pathModel = PathModel()
    @StateObject private var homeViewModel = HomeViewModel()
    @StateObject private var todoListViewModel = TodoListViewModel()
    @StateObject private var memoListViewModel = MemoListViewModel()
    
    var body: some View {
        NavigationStack(path: $pathModel.paths) {
            ZStack {
                TabView(selection: $homeViewModel.selectedTab) {
                    TodoListView()
                        .tabItem {
                            Image(systemName: homeViewModel.selectedTab == .todoList
                                  ? "checklist"
                                  : "checklist.unchecked"
                            )
                            
                        }
                        .tag(Tab.todoList)
                    
                    MemoListView()
                        .tabItem {
                            Image(systemName: homeViewModel.selectedTab == .memo
                                  ? "pencil.circle.fill"
                                  : "pencil.circle"
                            )
                        }
                        .tag(Tab.memo)
                    
                    SettingView()
                        .tabItem {
                            Image(systemName: homeViewModel.selectedTab == .setting
                                  ? "gearshape.fill"
                                  : "gearshape"
                            )
                        }
                        .tag(Tab.setting)
                }
                .tint(Color.orange)
                .environmentObject(homeViewModel)
                .environmentObject(todoListViewModel)
                .environmentObject(memoListViewModel)
            }
            .navigationDestination(for: PathType.self) { pathType in
                switch pathType {
                case .todoView:
                    TodoView()
                        .navigationBarBackButtonHidden()
                        .environmentObject(todoListViewModel)
                case let .memoView(isCreateMode, memo):
                    MemoView(
                        memoViewModel: isCreateMode
                        ? .init(memo: .init(title: "", content: "", date: .now))
                        : .init(memo: memo ?? .init(title: "", content: "", date: .now)),
                        isCreateMode: isCreateMode
                    )
                    .navigationBarBackButtonHidden()
                    .environmentObject(memoListViewModel)
                }
            }
        }
        .environmentObject(pathModel)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(PathModel())
            .environmentObject(TodoListViewModel())
            .environmentObject(MemoListViewModel())
    }
}
