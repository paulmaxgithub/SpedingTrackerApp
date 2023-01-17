//
//  AddCardViewButton.swift
//  SpedingTrackerApp
//
//  Created by PaulmaX on 17.01.23.
//

import SwiftUI

struct AddCardViewButton: View {
    
    var body: some View {
        Button(action: {
            //
        }, label: {
            Text("+ Card")
                .padding(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
                .foregroundColor(.white)
                .background(.black)
                .font(.system(size: 16, weight: .bold))
                .cornerRadius(5)
        })
    }
}
