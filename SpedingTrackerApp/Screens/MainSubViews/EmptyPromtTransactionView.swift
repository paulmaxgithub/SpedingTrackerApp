//
//  EmptyPromtTransactionView.swift
//  SpedingTrackerApp
//
//  Created by PaulmaX on 20.01.23.
//

import SwiftUI

struct EmptyPromtTransactionView: View {
    
    @Binding var isPresented: Bool
    
    var body: some View {
        
        VStack {
            Text("Get started by adding your first transaction")
                .padding(.horizontal, 48)
                .padding(.vertical)
                .multilineTextAlignment(.center)
            Button {
                isPresented.toggle()
            } label: {
                Text("+ Add Your First Card")
                    .padding(EdgeInsets(top: 10, leading: 14, bottom: 10, trailing: 14))
                    .foregroundColor(Color(.systemBackground))
                    .background(Color(.label))
                    .cornerRadius(5)
            }
        }
        .font(.system(size: 15, weight: .semibold))
    }
}
