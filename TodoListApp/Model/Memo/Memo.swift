//
//  Memo.swift
//  TodoListApp
//
//  Created by 최낙주 on 3/5/25.
//

import Foundation

struct Memo: Hashable {
    var title: String
    var content: String
    var date: Date
    var id = UUID()
    
    var convertedDate: String {
        String("\(date.formattedDay) - \(date.formattedTime)")
    }
}
