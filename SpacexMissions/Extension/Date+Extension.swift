//
//  Date+Extension.swift
//  SpacexMissions
//
//  Created by Florin Uscatu on 16.06.2022.
//  Copyright © 2022 Florin-Alexandru Uscatu. All rights reserved.
//

import Foundation

extension Date {
    
    var justTime: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter.string(from: self)
    }
    
    var justDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter.string(from: self)
    }
    
    var justYear: Int? {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY"
        return Int(formatter.string(from: self))
    }
    
    var daysSinceToday: Int? {
        return Calendar.current.dateComponents([.day], from: self, to: Date()).day
    }
    
}
