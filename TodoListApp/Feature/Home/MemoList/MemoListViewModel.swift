//
//  MemoListViewModel.swift
//  TodoListApp
//
//  Created by 최낙주 on 3/5/25.
//

import UIKit
import CoreData

class MemoListViewModel: ViewModel {
    @Published var memos: [Memo]
    @Published var removeMemos: [Memo]
    @Published var isDisplayRemoveMemoAlert: Bool
    
    var removeMemoCount: Int {
        return removeMemos.count
    }
    
    var navigationBarRightBtnMode: NavigationBtnType {
        isEditMode ? .complete : .edit
    }
    
    init(
        memos: [Memo] = MemoCoreDataManager.fetchData(),
        removeMemos: [Memo] = [],
        isDisplayRemoveMemoAlert: Bool = false
    ) {
        self.memos = memos
        self.removeMemos = removeMemos
        self.isDisplayRemoveMemoAlert = isDisplayRemoveMemoAlert
    }
}

extension MemoListViewModel {
    func addMemo(_ memo: Memo) {
        MemoCoreDataManager.saveData(memo)
        memos = MemoCoreDataManager.fetchData()
    }
    
    func updateMemo(_ memo: Memo) {
        MemoCoreDataManager.updateData(memo)
        memos = MemoCoreDataManager.fetchData()
    }
    
    func navigationRightBtnTapped() {
        if isEditMode {
            if removeMemos.isEmpty {
                isEditMode = false
            } else {
                setIsDisplayRemoveMemoAlert(true)
            }
        } else {
            isEditMode = true
        }
    }
    
    func setIsDisplayRemoveMemoAlert(_ isDisplay: Bool) {
        isDisplayRemoveMemoAlert = isDisplay
    }
    
    func memoRemoveSelectedBoxTapped(_ memo: Memo) {
        if let index = removeMemos.firstIndex(of: memo) {
            removeMemos.remove(at: index)
        } else {
            removeMemos.append(memo)
        }
    }
    
    func removeBtnTapped() {
        removeMemos.forEach { memo in
            MemoCoreDataManager.deleteData(memo)
        }
        removeMemos.removeAll()
        isEditMode = false
        memos = MemoCoreDataManager.fetchData()
    }
}
