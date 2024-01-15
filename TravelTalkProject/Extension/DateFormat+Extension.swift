//
//  DateFormat+Extension.swift
//  TravelTalkProject
//
//  Created by 남현정 on 2024/01/15.
//

import UIKit
// format하나 만들어서 어디서든 쓸 수 있다
extension DateFormatter {
    static let format = DateFormatter()
    
    /// "yyyy-MM-dd HH:mm"형식의 날짜를 받으면 원하는 형식으로 바꿔주는 함수
    func getDate(dateString: String, newDateFormat: String) -> String {
        DateFormatter.format.dateFormat = "yyyy-MM-dd HH:mm"

        let backToDate: Date = DateFormatter.format.date(from: dateString) ?? Date()
        
        DateFormatter.format.dateFormat = newDateFormat
        let result = DateFormatter.format.string(from: backToDate)
        
        return result
    }
}
