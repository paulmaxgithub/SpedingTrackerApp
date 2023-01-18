//
//  DeleteAllButton.swift
//  SpedingTrackerApp
//
//  Created by PaulmaX on 18.01.23.
//

import SwiftUI

struct DeleteAllButton: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var cards: FetchedResults<Card>
    init(_ cards: FetchedResults<Card>) { self.cards = cards }
    
    var body: some View {
        Button {
            cards.forEach({ viewContext.delete($0) })
            
            do {
                try viewContext.save()
            } catch (let error) {
                fatalError("Unresolved error with \(error.localizedDescription)")
            }
        } label: {
            Text("Delete All")
        }
    }
}
