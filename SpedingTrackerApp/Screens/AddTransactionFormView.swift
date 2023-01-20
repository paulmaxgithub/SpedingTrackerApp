//
//  AddTransactionFormView.swift
//  SpedingTrackerApp
//
//  Created by PaulmaX on 20.01.23.
//

import SwiftUI

struct AddTransactionFormView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var name     = ""
    @State private var amount   = ""
    @State private var date     = Date()
    @State private var photoData: Data?
    
    @State private var shouldPresentPhotoPicker = false
    
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
                        shouldPresentPhotoPicker.toggle()
                    } label: {
                        Text("Select Photo")
                    }
                    if let photoData = photoData, let image = UIImage.init(data: photoData) {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .clipped()
                    }
                }
            }
            .navigationTitle("Add Transaction")
            .navigationBarItems(leading: cancelButton, trailing: saveButton)
            .fullScreenCover(isPresented: $shouldPresentPhotoPicker, content: { PhotoPickerView(photoData: $photoData) })
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
