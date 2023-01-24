//
//  CategoriesListView.swift
//  SpedingTrackerApp
//
//  Created by PaulmaX on 23.01.23.
//

import SwiftUI

struct CategoriesListView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(
        keyPath: \TransactionCategory.timestamp, ascending: false)])
    private var categories: FetchedResults<TransactionCategory>
    
    @State private var name = ""
    @State private var color: Color = .red
    
    @Binding var selectedCategories: Set<TransactionCategory>
    
    var body: some View {
        Form {
            Section("SELECT A CATEGORY") {
                if !(categories.isEmpty) {
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
                    .onDelete { deleteCategory($0) }
                }
            }
            
            Section("CREATE A CATEGORY") {
                TextField("Name", text: $name)
                ColorPicker("Color", selection: $color)
                Button {
                    handleCreate()
                } label: {
                    HStack {
                        Spacer()
                        Text("Create")
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .padding(.vertical, 8)
                    .background(.blue)
                    .cornerRadius(5)
                }
                .buttonStyle(.plain)
            }
        }
        .navigationTitle("Categories")
    }
    
    private func handleCreate() {
        let category = TransactionCategory(context: viewContext)
        category.name = name
        category.color = UIColor(color).encode()
        category.timestamp = Date()
        try? viewContext.save()
        name = ""
    }
    
    private func deleteCategory(_ indexSet: IndexSet) {
        indexSet.forEach {
            selectedCategories.remove(categories[$0])
            viewContext.delete(categories[$0])
        }
        try? viewContext.save()
    }
}
