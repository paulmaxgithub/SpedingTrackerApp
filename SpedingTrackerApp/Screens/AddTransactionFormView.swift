//
//  AddTransactionFormView.swift
//  SpedingTrackerApp
//
//  Created by PaulmaX on 20.01.23.
//

import SwiftUI

struct AddTransactionFormView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var name     = ""
    @State private var amount   = ""
    @State private var date     = Date()
    @State private var photoData: Data?
    
    @State private var shouldPresentPhotoPicker = false
    @State private var selectedCategories = Set<TransactionCategory>()
    
    let card: Card
    
    init(_ card: Card) {
        self.card = card
        
//        let request = TransactionCategory.fetchRequest()
//        request.sortDescriptors = [.init(key: "timestamp", ascending: false)]
//        let transactionCategoryResult = try? viewContext.fetch(request)
//        if let first = transactionCategoryResult?.first {
//            _selectedCategories = .init(initialValue: [first])
//        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section("INFORMATION") {
                    TextField("Name", text: $name)
                    TextField("Amount", text: $amount)
                        .keyboardType(.numberPad)
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                }
                
                Section("CATEGORIES") {
                    NavigationLink(destination: {
                        CategoriesListView(selectedCategories: $selectedCategories)
                    }, label: {
                        Text("Select categories")
                    })
                    
                    let sortedByTimestampCategories = Array(selectedCategories).sorted(by: {
                        $0.timestamp?.compare($1.timestamp ?? Date()) == .orderedDescending
                    })
                    
                    ForEach(Array(sortedByTimestampCategories)) { category in
                        HStack(spacing: 12) {
                            if let colorData = category.color,
                               let uiColor = UIColor.color(data: colorData) {
                                let color = Color(uiColor)
                                Spacer()
                                    .frame(width: 30, height: 10)
                                    .background(color)
                            }
                            Text(category.name ?? "")
                        }
                    }
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
            let transaction = CardTransaction(context: viewContext)
            transaction.name = name
            transaction.amount = Float(amount) ?? 0
            transaction.timestamp = date
            transaction.photoData = photoData
            transaction.card = card
            transaction.categories = selectedCategories as NSSet
            try? viewContext.save()
            dismiss()
        } label: {
            Text("Save")
        }
    }
}
