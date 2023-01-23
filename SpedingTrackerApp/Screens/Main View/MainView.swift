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
    
    @State private var addCardFormShown         = false
    @State private var addTransactionFormShown  = false
    @State private var cardSelectedHash         = -1
    
    var currentCard: Card?
    
    var body: some View {
        NavigationView {
            ScrollView {
                if !(cards.isEmpty) {
                    TabView(selection: $cardSelectedHash) {
                        ForEach(cards) { _card in
                            CreditCardView(card: _card)
                                .padding(.bottom, 50)
                                .tag(_card.hash)
                        }
                    }
                    .frame(height: 280)
                    .tabViewStyle(.page(indexDisplayMode: .automatic))
                    .indexViewStyle(.page(backgroundDisplayMode: .always))
                    .onAppear(perform:  { cardSelectedHash = cards.first?.hash ?? -1 })
                    
                    EmptyPromtTransactionView(isPresented: $addTransactionFormShown)
                    
                    if let firstIndex = cards.firstIndex(where: { $0.hash ==  cardSelectedHash }) {
                        let card = cards[firstIndex]
                        CardTransactionView(card: card)
                    }
                } else {
                    EmptyPromptView(isPresented: $addCardFormShown)
                }
            }
            .navigationTitle("Credit Cards")
            .navigationBarItems(trailing: HStack {
                if !cards.isEmpty { AddCardButton(isPresented: $addCardFormShown) } })
            .navigationBarItems(leading: HStack { AddItemButton(); DeleteAllButton(cards) })
            
            //FULL SCREEN COVERS
            .fullScreenCover(isPresented: $addCardFormShown,  content: {
                AddCardFormView { cardSelectedHash = $0.hash } })
            .fullScreenCover(isPresented: $addTransactionFormShown) {
                if let firstIndex = cards.firstIndex(where: { $0.hash ==  cardSelectedHash }) {
                    let card = cards[firstIndex]
                    AddTransactionFormView(card: card)
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.shared.container.viewContext
        MainView().environment(\.managedObjectContext, viewContext)
    }
}
