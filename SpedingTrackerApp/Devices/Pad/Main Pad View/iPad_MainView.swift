//
//  iPad_MainView.swift
//  SpedingTrackerApp
//
//  Created by PaulmaX on 25.01.23.
//

import SwiftUI

struct iPad_MainView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(
        keyPath: \Card.timestamp, ascending: false)], animation: .default)
    private var cards: FetchedResults<Card>
    
    @State private var addCardFormShown = false
    @State private var selectedCard: Card?
    
    var body: some View {
        NavigationView {
            ScrollView {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(cards) { _card in
                            CreditCardView(card: _card)
                                .padding(.bottom, 15)
                                .onTapGesture { withAnimation { selectedCard = _card } }
                                .scaleEffect(selectedCard == _card ? 1.1 : 1)
                                .onAppear { selectedCard = _card }
                        }
                    }
                    .padding()
                }
                
                if let _card = selectedCard { TransactionsGridView(_card) }
            }
            .navigationTitle("Credit Cards")
            .navigationBarItems(trailing: AddCardButton(isPresented: $addCardFormShown))
            
            //SHEET
            .sheet(isPresented: $addCardFormShown, content: { AddCardFormView(didAddCard: nil) })
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct MainPadDeviceView_Previews: PreviewProvider {
    static var previews: some View {
        
        let viewContext = PersistenceController.shared.container.viewContext
        iPad_MainView()
            .environment(\.managedObjectContext, viewContext)
            .previewDevice(PreviewDevice(rawValue: "iPad Pro (9.7-inch)"))
            .environment(\.horizontalSizeClass, .compact)
            .previewInterfaceOrientation(.portrait)
    }
}
