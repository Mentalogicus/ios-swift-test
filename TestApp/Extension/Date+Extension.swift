//
//  Date+Extension.swift
//  TestApp
//
//  Created by Francis Moore on 2019-03-24.
//  Copyright © 2019 AlayaCare. All rights reserved.
//

import Foundation

extension Date {

    private static let dateFormat = "dd/MM/yyyy HH:mm:ss"

    static func fromString(_ string: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let date = dateFormatter.date(from: string)
        return date
    }

    static func random(daysBack: Int) -> Date? {
        let day = arc4random_uniform(UInt32(daysBack)) + 1
        let hour = arc4random_uniform(23)
        let minute = arc4random_uniform(59)

        let today = Date(timeIntervalSinceNow: 0)
        let gregorian  = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        var offsetComponents = DateComponents()
        offsetComponents.day = Int(day - 1)
        offsetComponents.hour = Int(hour)
        offsetComponents.minute = Int(minute)

        let randomDate = gregorian?.date(byAdding: offsetComponents, to: today, options: .init(rawValue: 0) )
        return randomDate
    }

    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = Date.dateFormat
        let dateAsString = formatter.string(from: self)
        return dateAsString
    }
}
