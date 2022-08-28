//
//  Date+Extensions.swift
//  FuelApp_SwiftUI
//
//  Created by Malith Kuruppu on 2022-08-28.
//

import Foundation

extension Date {
    var startDateOfMonth: Date {
        let components = Calendar.current.dateComponents([.year, .month], from: self)
        return Calendar.current.date(from: components)!
    }

    var endDateOfMonth: Date {
        var components = Calendar.current.dateComponents([.year, .month], from: self)
        components.month = (components.month ?? 0) + 1
        components.hour = (components.hour ?? 0) - 1
        return Calendar.current.date(from: components)!
    }

}
