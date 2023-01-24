//
//  EmptyPromtTransactionView.swift
//  SpedingTrackerApp
//
//  Created by PaulmaX on 20.01.23.
//

import SwiftUI

struct PromptTransactionView: View {
    
    @State private var addTransactionFormShown  = false
    
    let card: Card
    var fetchedRequest: FetchRequest<CardTransaction>
    init(_ card: Card) {
        self.card = card
        
        fetchedRequest = FetchRequest<CardTransaction>(
            entity: CardTransaction.entity(),
            sortDescriptors: [.init(key: "timestamp", ascending: false)],
            predicate: .init(format: "card == %@", card))
    }
    
    var body: some View {
        VStack {
            Text("Get started by adding your transaction")
                .padding(.horizontal, 48)
                .multilineTextAlignment(.center)
            Button {
                addTransactionFormShown.toggle()
            } label: {
                Text("+ Transaction")
                    .padding(EdgeInsets(top: 10, leading: 14, bottom: 10, trailing: 14))
                    .foregroundColor(Color(.systemBackground))
                    .background(Color(.label))
                    .cornerRadius(5)
            }
            
            ForEach(fetchedRequest.wrappedValue) { transaction in
                CardTransactionView(transaction: transaction)
            }
        }
        .font(.system(size: 15, weight: .semibold))
        
        //FULL SCREEN COVERS
        .fullScreenCover(isPresented: $addTransactionFormShown) { AddTransactionFormView(card) }
    }
}
