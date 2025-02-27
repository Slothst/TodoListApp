//
//  Date+Extension.swift
//  TodoListApp
//
//  Created by 최낙주 on 2/26/25.
//

import Foundation

extension Date {
    var formattedTime: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "a hh:mm"
        return dateFormatter.string(from: self)
    }
    
    var formattedDay: String {
        let now = Date()
        let calendar = Calendar.current
        
        let nowStartOfDay = calendar.startOfDay(for: now)
        let dateStartOfDay = calendar.startOfDay(for: self)
        let numOfDaysDifference = calendar.dateComponents([.day], from: nowStartOfDay, to: dateStartOfDay).day!
        
        if numOfDaysDifference == 0 {
            return "오늘"
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "ko_KR")
            dateFormatter.dateFormat = "M월 d일 E요일"
            return dateFormatter.string(from: self)
        }
    }
}
