//
//  EmptyPromptView.swift
//  SpedingTrackerApp
//
//  Created by PaulmaX on 19.01.23.
//

import SwiftUI

struct EmptyPromptView: View {
    
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            Text("You currently have no cards in system")
                .padding(.horizontal, 48)
                .padding(.vertical)
                .multilineTextAlignment(.center)
            Button {
                isPresented.toggle()
            } label: {
                Text("+ Add Your First Card")
                    .padding(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
                    .foregroundColor(Color(.systemBackground))
                    .background(Color(.label))
                    .cornerRadius(5)
            }
        }
        .font(.system(size: 22, weight: .semibold))
    }
}
