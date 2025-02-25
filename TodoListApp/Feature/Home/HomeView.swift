//
//  HomeView.swift
//  TodoListApp
//
//  Created by 최낙주 on 2/21/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var pathModel: PathModel
    @StateObject private var homeViewModel = HomeViewModel()
    
    var body: some View {
        ZStack {
            TabView(selection: $homeViewModel.selectedTab) {
                TodoListView()
                    .tabItem {
                        Image(systemName: homeViewModel.selectedTab == .todoList
                              ? "checklist"
                              : "checklist.unchecked"
                        )
                        .environment(\.symbolVariants, .none)
                        
                    }
                    .tag(Tab.todoList)
                
                MemoListView()
                    .tabItem {
                        Image(systemName: homeViewModel.selectedTab == .memo
                              ? "pencil.circle.fill"
                              : "pencil.circle"
                        )
                        .environment(\.symbolVariants, .none)
                    }
                    .tag(Tab.memo)
                
                SettingView()
                    .tabItem {
                        Image(systemName: homeViewModel.selectedTab == .setting
                              ? "gearshape.fill"
                              : "gearshape"
                        )
                        .environment(\.symbolVariants, .none)
                    }
                    .tag(Tab.setting)
            }
            .tint(Color.primary)
            .environmentObject(homeViewModel)
            
            SeperatorLineView()
        }
    }
}

private struct SeperatorLineView: View {
    fileprivate var body: some View {
        VStack {
            Spacer()
            
            Rectangle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.white, Color.gray.opacity(0.1)]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(height: 10)
                .padding(.bottom, 60)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(PathModel())
    }
}
