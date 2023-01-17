//
//  CreditCardView.swift
//  SpedingTrackerApp
//
//  Created by PaulmaX on 16.01.23.
//

import SwiftUI

struct CreditCardView: View {
    
    var body: some View {
            
            VStack(alignment: .leading, spacing: 12) {
                
                Text("Apple Blue Card")
                    .font(.system(size: 24, weight: .semibold))
                
                HStack {
                    Image("visa_icon")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 44)
                        .clipped()
                    Spacer()
                    Text("Balance: 100.000$")
                        .font(.system(size: 18, weight: .semibold))
                }
                
                Text("1239 1239 1239 1239")
                
                Text("Credit Card Limit: 5.000$")
                
                HStack {
                    Spacer()
                }
            }
            .padding()
            
            .foregroundColor(.white)
            .background(LinearGradient(colors: [.blue.opacity(0.6), .blue], startPoint: .center, endPoint: .bottom))
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(.black.opacity(0.5), lineWidth: 1))
            .cornerRadius(8)
            .shadow(radius: 5)
            
            .padding(.horizontal)
            .aspectRatio(1.586, contentMode: .fit)
    }
}
