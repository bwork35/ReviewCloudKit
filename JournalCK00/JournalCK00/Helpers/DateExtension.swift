//
//  DateExtension.swift
//  JournalCK00
//
//  Created by Bryan Workman on 2/5/21.
//

import Foundation

extension Date {
    func dateAsString() -> String {
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        
        return formatter.string(from: self)
    }
}
