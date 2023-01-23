//
//  CreditCardView.swift
//  SpedingTrackerApp
//
//  Created by PaulmaX on 16.01.23.
//

import SwiftUI
import CoreData

struct CreditCardView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var shouldShowActionSheet = false
    @State private var shouldShowEditForm = false
    
    @State var refreshID = UUID()
    
    let card: Card
    
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
            }
            
            HStack {
                let imageName = card.type?.lowercased() ?? "visa"
                Image("\(imageName)_icon")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 40)
                    .clipped()
                Spacer()
                Text("Balance: $10,000")
                    .font(.system(size: 18, weight: .semibold))
            }
            
            Text(card.number ?? "**** **** **** ****")
            
            HStack {
                Text("Credit Card Limit: $\((card.limit))")
                Spacer()
                VStack {
                    Text("Valid Thru")
                    Text("\(String(format: "%02d", card.expMonth))/\(String(card.expYear % 2000))")
                }
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
        
        //ACTION SHEET & FULL SCREEN COVER
        .actionSheet(isPresented: $shouldShowActionSheet) {
            .init(title: Text(card.name ?? "NO NAME"), buttons: [
                .default(Text("Edit"), action: { shouldShowEditForm.toggle() }),
                .destructive(Text("Delete Card"), action: { deleteCard() }), .cancel()])
        }
        .fullScreenCover(isPresented: $shouldShowEditForm, content: { AddCardFormView(card, didAddCard: nil) })
    }
    
    private func deleteCard() {
        withAnimation {
            card.transactions?.forEach({ viewContext.delete($0 as! NSManagedObject) })
            viewContext.delete(card)
            try? viewContext.save()
        }
    }
}
