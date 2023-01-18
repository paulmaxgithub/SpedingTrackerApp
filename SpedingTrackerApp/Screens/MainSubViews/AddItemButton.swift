//
//  AddItemButton.swift
//  SpedingTrackerApp
//
//  Created by PaulmaX on 18.01.23.
//

import SwiftUI

struct AddItemButton: View {
    var body: some View {
        Button {
            withAnimation {
                let viewContext = PersistenceController.shared.container.viewContext
                let card = Card(context: viewContext)
                card.timestamp = Date()
                do {
                    try viewContext.save()
                } catch {
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
            }
        } label: {
            Text("Add Item")
        }
    }
}
