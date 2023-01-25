//
//  CardTransactionView.swift
//  SpedingTrackerApp
//
//  Created by PaulmaX on 20.01.23.
//

import SwiftUI

fileprivate var dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .none
    return formatter
}()

struct CardTransactionView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var shouldPresentActionSheet = false
    
    @State var refreshID = UUID()
    
    let transaction: CardTransaction
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(transaction.name ?? "")
                        .font(.headline)
                    if let date = transaction.timestamp { Text(dateFormatter.string(from: date)) }
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
                    
                    Text(String(format: "$%.2f", transaction.amount))
                }
            }
            
            if let categories = transaction.categories as? Set<TransactionCategory> {
                
                let sortedByTimestampCategories = Array(categories).sorted(by: {
                    $0.timestamp?.compare($1.timestamp ?? Date()) == .orderedDescending
                })
                
                HStack {
                    ForEach(sortedByTimestampCategories) { category in
                        Text(category.name ?? "")
                            .padding(EdgeInsets(top: 4, leading: 6, bottom: 4, trailing: 6))
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                            .background(
                                HStack {
                                    if let colorData = category.color,
                                       let uiColor = UIColor.color(data: colorData) {
                                        Color(uiColor)
                                    }
                                }
                            )
                            .cornerRadius(5)
                    }
                    Spacer()
                }
            }
            
            if let photoData = transaction.photoData, let _uiImage = UIImage(data: photoData) {
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
            .init(title: Text(transaction.name ?? "NO NAME"),
                  buttons: [.destructive(Text("Delete"), action: { deleteTransaction() }), .cancel()])
        }
    }
    
    private func deleteTransaction() {
        withAnimation {
            viewContext.delete(transaction)
            try? viewContext.save()
        }
    }
}
