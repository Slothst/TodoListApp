//
//  PathType.swift
//  TodoListApp
//
//  Created by 최낙주 on 2/24/25.
//

import Foundation

enum PathType: Hashable {
    case todoView
    case memoView(isCreateMode: Bool, memo: Memo?)
}
