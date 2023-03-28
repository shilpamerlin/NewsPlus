//
//  Date+Extension.swift
//  CBCNewsFeed
//
//  Created by Shilpa Joy on 2023-02-25.
//

import UIKit

extension Date {
    
    func getElapsedInterval() -> String {
        let interval = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self, to: Date())
        
        if let hour = interval.hour, hour > 0 {
            return hour == 1 ? "An hour ago" :
            "\(hour)" + " " + "hours ago"
        } else if let minute = interval.minute, minute > 0 {
            return minute == 1 ? "\(minute)" + " " + "minute ago" :
            "\(minute)" + " " + "minutes ago"
        } else if let second = interval.second, second > 0 {
            return second == 1 ? "\(second)" + " " + "second ago" :
            "\(second)" + " " + "seconds ago"
        } else {
            return "a moment ago"
        }
    }
}
