//
//  TodoViewModel.swift
//  TodoListApp
//
//  Created by 최낙주 on 2/26/25.
//

import Foundation

class TodoViewModel: ObservableObject {
    @Published var title: String
    @Published var time: Date
    @Published var day: Date
    @Published var isCalendarDisplay: Bool
    
    init(title: String = "",
         time: Date = Date(),
         day: Date = Date(),
         isCalendarDisplay: Bool = false
    ) {
        self.title = title
        self.time = time
        self.day = day
        self.isCalendarDisplay = isCalendarDisplay
    }
}

extension TodoViewModel {
    func setIsCalendarDisplay(_ isDisplay: Bool) {
        isCalendarDisplay = isDisplay
    }
}
