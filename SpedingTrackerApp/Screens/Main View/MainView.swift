//
//  MainView.swift
//  SpedingTrackerApp
//
//  Created by PaulmaX on 16.01.23.
//

import SwiftUI

struct MainView: View {
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(
        keyPath: \Card.timestamp, ascending: false)], animation: .default)
    private var cards: FetchedResults<Card>
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(
        keyPath: \CardTransaction.timestamp, ascending: false)],animation: .default)
    private var transactions: FetchedResults<CardTransaction>
    
    @State private var addCardFormShown = false
    @State private var addTransactionFormShown = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                if !(cards.isEmpty) {
                    TabView {
                        ForEach(cards) { _card in
                            CreditCardView(card: _card)
                                .padding(.bottom, 50)
                        }
                    }
                    .frame(height: 280)
                    .tabViewStyle(.page(indexDisplayMode: .always))
                    .indexViewStyle(.page(backgroundDisplayMode: .always))
                    
                    EmptyPromtTransactionView(isPresented: $addTransactionFormShown)
                    
                    if !(transactions.isEmpty) {
                        ForEach(transactions) { _transaction in
                            TransactionView(transaction: _transaction)       
                        }
                    }
                } else {
                    EmptyPromptView(isPresented: $addCardFormShown)
                }
            }
            .navigationTitle("Credit Cards")
            .navigationBarItems(trailing: HStack {
                if !cards.isEmpty { AddCardButton(isPresented: $addCardFormShown) } })
            .navigationBarItems(leading: HStack { AddItemButton(); DeleteAllButton(cards) })
            .fullScreenCover(isPresented: $addCardFormShown,  content: { AddCardFormView() })
            .fullScreenCover(isPresented: $addTransactionFormShown) { AddTransactionFormView() }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.shared.container.viewContext
        MainView().environment(\.managedObjectContext, viewContext)
    }
}
