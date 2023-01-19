//
//  CreditCardView.swift
//  SpedingTrackerApp
//
//  Created by PaulmaX on 16.01.23.
//

import SwiftUI

struct CreditCardView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var shouldShowActionSheet = false
    
    let card: Card
    
    private func deleteCard() {
        viewContext.delete(card)
        try? viewContext.save()
    }
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 12) {
            
            HStack {
                Text(card.name ?? "NO NAME")
                    .font(.system(size: 24, weight: .semibold))
                    .lineLimit(1)
                Spacer()
                Button {
                    shouldShowActionSheet.toggle()
                } label: {
                    Image(systemName: "ellipsis")
                        .font(.system(size: 28, weight: .bold))
                }
                .actionSheet(isPresented: $shouldShowActionSheet) {
                    .init(title: Text(card.name ?? ""), message: Text("Options"),
                          buttons: [
                            .destructive(Text("Delete Card"), action: { deleteCard() }),
                            .cancel()
                          ])
                }
            }
            
            HStack {
                Image("visa_icon")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 40)
                    .clipped()
                Spacer()
                Text("Balance: $100,000")
                    .font(.system(size: 18, weight: .semibold))
            }
            
            Text(card.number ?? "NO NUMBER")
            
            Text("Credit Card Limit: $\((card.limit))")
            
            HStack {
                Spacer()
            }
        }
        .padding()
        
        .foregroundColor(.white)
        .background(
            VStack {
                if let colorData = card.color,
                   let uiColor = UIColor.color(data: colorData),
                   let color = Color(uiColor) {
                    LinearGradient(colors: [color.opacity(0.6), color], startPoint: .center, endPoint: .bottom)
                } else {
                    Color.gray.opacity(0.2)
                }
            })
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(.black.opacity(0.5), lineWidth: 1))
        .cornerRadius(8)
        .shadow(radius: 5)
        
        .padding(.horizontal)
        .aspectRatio(1.586, contentMode: .fit)
    }
}
