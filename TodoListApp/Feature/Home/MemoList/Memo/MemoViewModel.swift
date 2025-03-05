//
//  MemoViewModel.swift
//  TodoListApp
//
//  Created by 최낙주 on 3/5/25.
//

import Foundation

class MemoViewModel: ObservableObject {
    @Published var memo: Memo
    
    init(memo: Memo) {
        self.memo = memo
    }
}
