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
                //            SeperatorLineView()
            }
            .navigationDestination(for: PathType.self) { pathType in
                switch pathType {
                case .todoView:
                    TodoView()
                        .navigationBarBackButtonHidden()
                        .environmentObject(todoListViewModel)
                default:
                    EmptyView()
                }
            }
        }
        .environmentObject(pathModel)
    }
}

private struct SeperatorLineView: View {
    fileprivate var body: some View {
        VStack {
            Spacer()
            
//            Rectangle()
//                .fill(
//                    LinearGradient(
//                        gradient: Gradient(colors: [Color.primary, Color.gray.opacity(0.1)]),
//                        startPoint: .top,
//                        endPoint: .bottom
//                    )
//                )
//                .frame(height: 10)
//                .padding(.bottom, 60)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(TodoListViewModel())
    }
}
