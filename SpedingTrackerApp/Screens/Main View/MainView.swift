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
    @State private var cardSelectedIndex        = 0
    
    var body: some View {
        NavigationView {
            ScrollView {
                if !(cards.isEmpty) {
                    TabView(selection: $cardSelectedIndex) {
                        ForEach(0..<cards.count) { i in
                            let card = cards[i]
                            CreditCardView(card: card)
                                .padding(.bottom, 50)
                                .tag(i)
                        }
                    }
                    .frame(height: 280)
                    .tabViewStyle(.page(indexDisplayMode: .always))
                    .indexViewStyle(.page(backgroundDisplayMode: .always))
                    
                    EmptyPromtTransactionView(isPresented: $addTransactionFormShown)
                    CardTransactionView(card: cards[cardSelectedIndex])
                } else {
                    EmptyPromptView(isPresented: $addCardFormShown)
                }
            }
            .navigationTitle("Credit Cards")
            .navigationBarItems(trailing: HStack {
                if !cards.isEmpty { AddCardButton(isPresented: $addCardFormShown) } })
            .navigationBarItems(leading: HStack { AddItemButton(); DeleteAllButton(cards) })
            
            //FULL SCREEN COVERS
            .fullScreenCover(isPresented: $addCardFormShown,  content: { AddCardFormView() })
            .fullScreenCover(isPresented: $addTransactionFormShown) {
                AddTransactionFormView(card: cards[cardSelectedIndex]) }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.shared.container.viewContext
        MainView().environment(\.managedObjectContext, viewContext)
    }
}
