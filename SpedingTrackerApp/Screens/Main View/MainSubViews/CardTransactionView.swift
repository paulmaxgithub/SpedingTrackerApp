//
//  CardTransactionView.swift
//  SpedingTrackerApp
//
//  Created by PaulmaX on 20.01.23.
//

import SwiftUI
import CoreData

fileprivate var dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .none
    return formatter
}()

struct CardTransactionView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var shouldPresentActionSheet = false
    
    let card: Card
    var fetchedRequest: FetchRequest<CardTransaction>
    init(card: Card) {
        self.card = card
        
        fetchedRequest = FetchRequest<CardTransaction>(
            entity: CardTransaction.entity(),
            sortDescriptors: [.init(key: "timestamp", ascending: false)],
            predicate: .init(format: "card == %@", card))
    }
    
    var body: some View {
        
        ForEach(fetchedRequest.wrappedValue) { _transaction in
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text(_transaction.name ?? "")
                            .font(.headline)
                        if let date = _transaction.timestamp { Text(dateFormatter.string(from: date)) }
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        Button {
                            shouldPresentActionSheet.toggle()
                        } label: {
                            Image(systemName: "ellipsis")
                                .font(.system(size: 24, weight: .bold))
                        }
                        .padding(EdgeInsets(top: 6, leading: 8, bottom: 4, trailing: 0))
                        
                        Text(String(format: "$%.2f",_transaction.amount))
                    }
                }
                
                if let photoData = _transaction.photoData, let _uiImage = UIImage(data: photoData) {
                    Image(uiImage: _uiImage)
                        .resizable()
                        .scaledToFill()
                }
            }
            .padding()
            .background(Color(.systemBackground))
            .foregroundColor(Color(.label))
            .cornerRadius(5)
            .shadow(color: Color(.label), radius: 5, x: 0, y: 0)
            .padding()
            
            //ACTION SHEET
            .actionSheet(isPresented: $shouldPresentActionSheet) {
                .init(title: Text(_transaction.name ?? "NO NAME"),
                      buttons: [.destructive(Text("Delete"), action: { deleteTransaction(_transaction) }), .cancel()])
            }
        }
    }
    
    private func deleteTransaction(_ transaction: NSManagedObject) {
        withAnimation {
            viewContext.delete(transaction)
            try? viewContext.save()
        }
    }
}
