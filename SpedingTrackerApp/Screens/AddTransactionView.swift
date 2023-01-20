//
//  AddTransactionView.swift
//  SpedingTrackerApp
//
//  Created by PaulmaX on 20.01.23.
//

import SwiftUI

struct AddTransactionView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var name = ""
    @State private var amount = ""
    @State private var date = Date()
    
    var body: some View {
        NavigationView {
            Form {
                Section("INFORMATION") {
                    TextField("Name", text: $name)
                    TextField("Amount", text: $amount)
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                    NavigationLink(destination: { Text("MANY").navigationTitle("MANY") }, label: { Text("Many to Many") })
                }
                
                Section("PHOTO / RECEIPT") {
                    Button {
                        //
                    } label: {
                        Text("Select Photo")
                    }
                }
            }
            .navigationTitle("Add Transaction")
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
        Button {
            //
        } label: {
            Text("Save")
        }
        
    }
}
