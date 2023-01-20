//
//  MainView.swift
//  SpedingTrackerApp
//
//  Created by PaulmaX on 16.01.23.
//

import SwiftUI

struct MainView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Card.timestamp, ascending: false)],
                  animation: .default) private var cards: FetchedResults<Card>
    
    @State private var addCardFormShown = false
    @State private var addTransactionFormShown = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                if !(cards.isEmpty) {
                    TabView {
                        ForEach(cards) { card in
                            CreditCardView(card: card)
                                .padding(.bottom, 50)
                        }
                    }
                    .frame(height: 280)
                    .tabViewStyle(.page(indexDisplayMode: .always))
                    .indexViewStyle(.page(backgroundDisplayMode: .always))
                    
                    EmptyPromtTransactionView(isPresented: $addTransactionFormShown)
                } else {
                    EmptyPromptView(isPresented: $addCardFormShown)
                }
            }
            .navigationTitle("Credit Cards")
            .navigationBarItems(trailing: HStack {
                if !cards.isEmpty { AddCardButton(isPresented: $addCardFormShown) } })
            .navigationBarItems(leading: HStack { AddItemButton(); DeleteAllButton(cards) })
            .fullScreenCover(isPresented: $addCardFormShown,  content: { AddCardFormView() })
            .fullScreenCover(isPresented: $addTransactionFormShown) { AddTransactionView() }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.shared.container.viewContext
        MainView().environment(\.managedObjectContext, viewContext)
    }
}
