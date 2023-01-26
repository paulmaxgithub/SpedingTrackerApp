//
//  DateFormatter+EXT.swift
//  SpedingTrackerApp
//
//  Created by PaulmaX on 26.01.23.
//

import Foundation

extension DateFormatter {
    
    static let shortFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter
    }()
}
