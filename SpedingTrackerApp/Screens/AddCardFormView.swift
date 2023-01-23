//
//  AddCardFormView.swift
//  SpedingTrackerApp
//
//  Created by PaulmaX on 17.01.23.
//

import SwiftUI

fileprivate enum CardType: String, CaseIterable {
    case Visa, Mastercard, Discover, Citibank
}

typealias DidAddCard = ((Card) -> Void)?

struct AddCardFormView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var name       = ""
    @State private var cardNumber = ""
    @State private var cardLimit  = ""
    @State private var cardType: CardType = .Visa
    
    @State private var month = 1
    @State private var year = Calendar.current.component(.year, from: Date())
    
    @State private var color: Color = .blue
    
    let card: Card?
    var didAddCard: DidAddCard = nil
    init(_ card: Card? = nil, didAddCard: DidAddCard) {
        self.card = card
        self.didAddCard = didAddCard
        
        _name       = State(initialValue: card?.name ?? "")
        _cardNumber = State(initialValue: card?.number ?? "")
        if let limit = card?.limit { _cardLimit  = State(initialValue: String(limit)) }
        _cardType   = State(initialValue: CardType(rawValue: (card?.type) ?? CardType.Visa.rawValue) ?? .Visa)
        _month      = State(initialValue: Int(card?.expMonth ?? 1))
        _year       = State(initialValue: Int(card?.expYear ?? Int16(Calendar.current.component(.year, from: Date()))))
        _color      = State(initialValue: Color(UIColor.color(data: card?.color ?? Data()) ?? .blue))
    }
    
    var body: some View {
        NavigationView {
            Form {
                
                Section("CARD INFORMATION") {
                    TextField("Name", text: $name)
                    TextField("Credit Card Number", text: $cardNumber)
                        .keyboardType(.numberPad)
                    TextField("Card Limit", text: $cardLimit)
                        .keyboardType(.numberPad)
                    Picker("Type", selection: $cardType) {
                        ForEach(CardType.allCases, id: \.self) { Text("\($0.rawValue)") }
                    }
                }
                
                Section("EXPIRATION") {
                    Picker("Month", selection: $month) {
                        ForEach(1...12, id: \.self) { Text("\($0)") }
                    }
                    Picker("Year", selection: $year) {
                        ForEach(year..<year + 20, id: \.self) { Text(String($0)) }
                    }
                }
                
                Section("COLOR") {
                    ColorPicker("Color", selection: $color)
                }
            }
            .navigationTitle(card != nil ? "Edit Credit Card" : "Add Credit Card")
            .navigationBarItems(leading: cancelButton, trailing: saveButton)
        }
    }
    
    private var cancelButton: some View {
        Button(action: {
            dismiss()
        }, label: {
            Text("Cancel")
        })
    }
    
    private var saveButton: some View {
        Button(action: {
            let card = card != nil ? card! : Card(context: viewContext)
            card.name       = name
            card.type       = cardType.rawValue
            card.number     = cardNumber
            card.limit      = Int32(cardLimit) ?? 0
            card.expMonth   = Int16(month)
            card.expYear    = Int16(year)
            card.color      = UIColor(color).encode()
            card.timestamp  = Date()
            try? viewContext.save()
            
            didAddCard?(card)
            dismiss()
        }, label: {
            Text("Save")
        })
    }
}
