//
//  DeviceIdiomView.swift
//  SpedingTrackerApp
//
//  Created by PaulmaX on 25.01.23.
//

import SwiftUI

struct DeviceIdiomView: View {
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            MainView()
        } else {
            if horizontalSizeClass == .compact {
                Color.blue
            } else {
                iPad_MainView()
            }
        }
    }
}

struct DeviceIdiomView_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
//            DeviceIdiomView()
//                .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro"))
            DeviceIdiomView()
                .previewDevice(PreviewDevice(rawValue: "iPad Pro (9.7-inch)"))
                .environment(\.horizontalSizeClass, .compact)
                .previewInterfaceOrientation(.landscapeLeft)
            DeviceIdiomView()
                .previewDevice(PreviewDevice(rawValue: "iPad Pro (9.7-inch)"))
                .environment(\.horizontalSizeClass, .regular)
        }
    }
}
