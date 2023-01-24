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
    
    var body: some View {
        Form {
            Section("SELECT A CATEGORY") {
                if !(categories.isEmpty) {
                    ForEach(categories) { category in
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
                    .onDelete { onDeleteCategory($0)}
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
    
    private func onDeleteCategory(_ indexSet: IndexSet) {
        indexSet.forEach { viewContext.delete(categories[$0]) }
        try? viewContext.save()
    }
}

struct CategoriesListView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesListView()
            .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
