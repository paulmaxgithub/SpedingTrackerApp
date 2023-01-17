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

struct AddCardFormView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var name       = ""
    @State private var cardNumber = ""
    @State private var cardLimit  = ""
    @State private var cardType: CardType = .Visa
    
    @State private var month = 1
    @State private var year = Calendar.current.component(.year, from: Date())
    
    @State private var color: Color = .blue
    
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
            .navigationTitle("Add Credit Card")
            .navigationBarItems(leading: Button(action: {
                dismiss()
            }, label: {
                Text("Cancel")
            }))
        }
    }
}

struct AddCardFormView_Previews: PreviewProvider {
    static var previews: some View {
        AddCardFormView()
    }
}