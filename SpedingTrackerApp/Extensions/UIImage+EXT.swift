//
//  UIImage+EXT.swift
//  SpedingTrackerApp
//
//  Created by PaulmaX on 23.01.23.
//

import UIKit

extension UIImage {
    
    func resized(to newSize: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: newSize).image { _ in
            let hScale = newSize.height / size.height
            let wScale = newSize.width / size.width
            let scale = max(hScale, wScale) //scaleToFill
            let resizedSize = CGSize(width: size.width * scale, height: size.height * scale)
            var middle = CGPoint.zero
            
            if resizedSize.width > newSize.width {
                middle.x -= (resizedSize.width - newSize.width) / 2
            }
            
            if resizedSize.height > newSize.height {
                middle.x -= (resizedSize.height - newSize.height) / 2
            }
            
            draw(in: CGRect(origin: middle, size: resizedSize))
        }
    }
}
