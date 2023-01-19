//
//  AddCardButton.swift
//  SpedingTrackerApp
//
//  Created by PaulmaX on 17.01.23.
//

import SwiftUI

struct AddCardButton: View {
    
    @Binding var isPresented: Bool
    
    var body: some View {
        Button(action: {
            isPresented.toggle()
        }, label: {
            Text("+ Card")
                .padding(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
                .foregroundColor(Color(.systemBackground))
                .background(Color(.label))
                .font(.system(size: 16, weight: .bold))
                .cornerRadius(5)
        })
    }
}
