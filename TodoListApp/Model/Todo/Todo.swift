//
//  Todo.swift
//  TodoListApp
//
//  Created by 최낙주 on 2/26/25.
//

import Foundation

struct Todo: Hashable {
    var title: String
    var time: Date
    var day: Date
    var selected: Bool
    
    var convertedDayAndTime: String {
        String("Reminder at \(day.formattedDay) - \(time.formattedTime)")
    }
}
