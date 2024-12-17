//
//  Date+Extension.swift
//  test
//
//  Created by Jorge Palomino on 16/08/2023.
//

import UIKit

extension Date {
    
    func toString(format:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "en_GB")
        
        
        var output = dateFormatter.string(from: self as Date)
        output = output.replacingOccurrences(of: "AM", with: "am")
        output = output.replacingOccurrences(of: "PM", with: "pm")
        return output
    }
    
    static func numberOfMinutes(for date: Date) -> Int {
        let calendar = Calendar.current
        let minutes = calendar.component(.minute, from: date)
        return minutes
      }

    var readableDate:String {
        if Calendar.current.isDateInToday(self) {
            return "Today"
        }
        return self.toString(format: "MMMM d, YYYY")
    }
    
    var readableTime:String {
        return self.toString(format: "h:mm a")
    }
    
    var tbcDate:String {

    
        return self.toString(format: "MMMM YYYY")
    }

    var phase2ReadableDate: String {

        let curDate = Date().timeIntervalSince1970
        let compDate = self.timeIntervalSince1970
        let timeDifference = curDate - compDate

        if timeDifference < 300 {
            return "Just now"

        } else if timeDifference < 3600 {
            let time = Int(timeDifference/60)
            if time > 1 {
                return "\(time) mins"
            }
            return "\(time) min"

        } else if timeDifference < 86400 {
            return "\(Int(timeDifference/3600)) h"

        } else if timeDifference < 604800 {
            return "\(Int(timeDifference / 86400)) d"

        } else if timeDifference < 2678400 {
            return "\(Int(timeDifference / 604800)) w"

        } else if timeDifference < 31536000 {
            return "\(Int(timeDifference / (60*60*24*31))) m"

        } else {

            return "\(Int(timeDifference / 31536000)) y"
        }
    }

    var humanReadableDate: String {

        let curDate = Date().timeIntervalSince1970
        let compDate = self.timeIntervalSince1970
        let timeDifference = curDate - compDate

        if timeDifference < 300 {

            return "Just Now"

        } else if timeDifference < 3600 {

            return "\(Int(timeDifference/60))min ago"

        } else if timeDifference < 86400 {

            return "\(Int(timeDifference/3600))h ago"

        } else if timeDifference < 604800 {

            return "\(Int(timeDifference / 86400))d ago"

        } else if timeDifference < 2678400 {

            return "\(Int(timeDifference / 604800))w ago"

        } else if timeDifference < 31536000 {
            return "\(Int(timeDifference / (60*60*24*31)))m ago"

        } else {

            return "\(Int(timeDifference / 31536000))y ago"
        }
    }
    
    var twoDayAgo: Date {
        return Calendar.current.date(byAdding: .day, value: -2, to: Date())!
    }

    func soleStringFromDate() -> String {
        let df = DateFormatter()
        df.dateFormat = "MMMM d, yyyy"

        return df.string(from: self)
    }

    static func stringFromDate(_ date: Date) -> String? {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return df.string(from: date)
    }
    
    static func shortStringFromDate(_ date: Date?) -> String {
        if let date = date{
            let df = DateFormatter()
            df.dateFormat = "yyyy-MM-dd"
            return df.string(from: date)
        } else {
            return "Unknown"
        }
       
    }

    static func dateFromString(_ string: String) -> Date? {
        return Date.dateFromString(string, format: "yyyy-MM-dd HH:mm:ss")
    }

    static func dateFromString(_ string: String, format:String) -> Date? {
        let df = DateFormatter()
        df.dateFormat = format
        return df.date(from: string)
    }
    
    static func randomBetween(start: Date, end: Date) -> Date {
        var date1 = start
        var date2 = end
        if date2 < date1 {
            let temp = date1
            date1 = date2
            date2 = temp
        }
        let span = TimeInterval.random(in: date1.timeIntervalSinceNow...date2.timeIntervalSinceNow)
        return Date(timeIntervalSinceNow: span)
    }
    func adding(minutes: Int) -> Date {
        return Calendar.current.date(byAdding: .minute, value: minutes, to: self)!
    }
}
