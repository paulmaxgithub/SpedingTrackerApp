//
//  FilterSheetView.swift
//  SpedingTrackerApp
//
//  Created by PaulmaX on 24.01.23.
//

import SwiftUI

struct FilterSheetView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(
        keyPath: \TransactionCategory.timestamp, ascending: false)])
    private var categories: FetchedResults<TransactionCategory>
    
    @State var selectedCategories = Set<TransactionCategory>()
    
    let filterDidSave: ((Set<TransactionCategory>) -> Void)
    
    var body: some View {
        NavigationView {
            Form {
                ForEach(categories) { category in
                    Button {
                        if selectedCategories.contains(category) {
                            selectedCategories.remove(category)
                        } else {
                            selectedCategories.insert(category)
                        }
                    } label: {
                        HStack(spacing: 12) {
                            if let colorData = category.color,
                               let uiColor = UIColor.color(data: colorData) {
                                let color = Color(uiColor)
                                Spacer()
                                    .frame(width: 30, height: 10)
                                    .background(color)
                            }
                            Text(category.name ?? "")
                                .foregroundColor(Color(.label))
                            Spacer()
                            if selectedCategories.contains(category) {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                }
            }
            .navigationTitle("Select Filters")
            .navigationBarItems(trailing: saveButton)
        }
    }
    
    private var saveButton: some View {
        Button {
            dismiss()
            filterDidSave(selectedCategories)
        } label: {
            Text("Save")
                .foregroundColor(.blue)
        }
        .padding()
        .font(.system(size: 18, weight: .semibold, design: .default))
    }
}
