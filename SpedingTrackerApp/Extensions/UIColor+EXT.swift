//
//  UIColor+EXT.swift
//  SpedingTrackerApp
//
//  Created by PaulmaX on 18.01.23.
//

import UIKit

extension UIColor {
    
    class func color(data: Data) -> UIColor? {
        return try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? UIColor
    }
    
    func encode() -> Data? {
        return try? NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
    }
}
