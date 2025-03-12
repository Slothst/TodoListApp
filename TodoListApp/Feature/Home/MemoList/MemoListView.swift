//
//  MemoListView.swift
//  TodoListApp
//
//  Created by 최낙주 on 2/24/25.
//

import SwiftUI

struct MemoListView: View {
    @EnvironmentObject private var pathModel: PathModel
    @EnvironmentObject private var memoListViewModel: MemoListViewModel
    @EnvironmentObject private var homeViewModel: HomeViewModel
    
    var body: some View {
        ZStack {
            VStack {
                if !memoListViewModel.memos.isEmpty {
                    CustomNavigationBar(
                        isLeftBtnDisplay: false,
                        rightBtnAction: {
                            memoListViewModel.navigationRightBtnTapped()
                        },
                        rightBtnType: memoListViewModel.navigationBarRightBtnMode
                    )
                } else {
                    Spacer()
                        .frame(height: 30)
                }
                TitleView()
                    .padding(.top, 30)
                
                if memoListViewModel.memos.isEmpty {
                    AnnouncementView()
                } else {
                    MemoListContentView()
                        .padding(.top, 20)
                }
            }
            
            WriteMemoBtnView()
                .padding(.trailing, 20)
                .padding(.bottom, 50)
        }
        .alert(
            memoListViewModel.removeMemoCount == 1
            ? "Are you sure you want to delete \(memoListViewModel.removeMemoCount) memo?"
            : "Are you sure you want to delete \(memoListViewModel.removeMemoCount) memos?",
            isPresented: $memoListViewModel.isDisplayRemoveMemoAlert
        ) {
            Button("delete", role: .destructive) {
                memoListViewModel.removeBtnTapped()
            }
            Button("cancel", role: .cancel) { }
        }
        .onChange(of: memoListViewModel.memos) { memos in
            homeViewModel.setMemosCount(memos.count)
        }
        .onDisappear {
            memoListViewModel.isEditMode = false
        }
    }
}

private struct TitleView: View {
    @EnvironmentObject private var memoListViewModel: MemoListViewModel
    
    fileprivate var body: some View {
        HStack {
            if memoListViewModel.memos.isEmpty {
                Text("Add your memos!")
            } else {
                if memoListViewModel.memos.count == 1 {
                    Text("You have \(memoListViewModel.memos.count) memo.")
                } else {
                    Text("You have \(memoListViewModel.memos.count) memos.")
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
                
            Text("\"Wish list\"")
            Text("\"Do some homework\"")
            Text("\"Watch Netflix\"")
            
            Spacer()
        }
        .font(.system(size: 16))
        .foregroundStyle(.secondary)
    }
}

private struct MemoListContentView: View {
    @EnvironmentObject private var memoListViewModel: MemoListViewModel
    
    fileprivate var body: some View {
        VStack {
            HStack {
                Text("Memo list")
                    .font(.system(size: 16, weight: .bold))
                    .padding(.leading, 20)
                
                Spacer()
            }
            
            ScrollView(.vertical) {
                VStack(spacing: 0) {
                    Rectangle()
                        .fill(Color.gray.opacity(0.5))
                        .frame(height: 1)
                    
                    ForEach(memoListViewModel.memos, id: \.self) { memo in
                        MemoCellView(memo: memo)
                    }
                }
            }
        }
    }
}

private struct MemoCellView: View {
    @EnvironmentObject private var pathModel: PathModel
    @EnvironmentObject private var memoListViewModel: MemoListViewModel
    @State private var isSelected: Bool
    private var memo: Memo
    
    fileprivate init(
        isSelected: Bool = false,
        memo: Memo
    ) {
        _isSelected = State(initialValue: isSelected)
        self.memo = memo
    }
    
    fileprivate var body: some View {
        Button {
            pathModel.paths.append(.memoView(isCreateMode: false, memo: memo))
        } label: {
            VStack(spacing: 10) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(memo.title)
                            .lineLimit(1)
                            .font(.system(size: 16))
                            .foregroundStyle(Color.primary)
                        
                        Text(memo.convertedDate)
                            .font(.system(size: 12))
                            .foregroundStyle(Color.gray)
                    }
                    
                    Spacer()
                    
                    if memoListViewModel.isEditMode {
                        Button {
                            isSelected.toggle()
                            memoListViewModel.memoRemoveSelectedBoxTapped(memo)
                        } label: {
                            isSelected ?
                            Image(systemName: "checkmark.square.fill")
                                .font(.system(size: 20)) :
                            Image(systemName: "square")
                                .font(.system(size: 20))
                        }
                    }
                }
                .padding(.horizontal, 30)
                .padding(.top, 10)
                
                Rectangle()
                    .fill(Color.gray.opacity(0.5))
                    .frame(height: 1)
            }
        }
    }
}

private struct WriteMemoBtnView: View {
    @EnvironmentObject private var pathModel: PathModel
    @EnvironmentObject private var memoListViewModel: MemoListViewModel
    
    fileprivate var body: some View {
        if !memoListViewModel.isEditMode {
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button {
                        pathModel.paths.append(.memoView(isCreateMode: true, memo: nil))
                    } label: {
                        Image(systemName: "pencil.circle.fill")
                            .font(.system(size: 50))
                    }
                    .tint(Color.orange)
                }
            }
        }
    }
}

struct MemoListView_Previews: PreviewProvider {
    static var previews: some View {
        MemoListView()
            .environmentObject(PathModel())
            .environmentObject(MemoListViewModel())
    }
}
