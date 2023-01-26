//
//  TransactionsGridView.swift
//  SpedingTrackerApp
//
//  Created by PaulmaX on 25.01.23.
//

import SwiftUI

struct TransactionsGridView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var shouldPresentSheet = false
    
    let card: Card
    var fetchedRequest: FetchRequest<CardTransaction>
    
    init(_ card: Card) {
        self.card = card
        
        fetchedRequest = FetchRequest<CardTransaction>(
            entity: CardTransaction.entity(),
            sortDescriptors: [.init(key: "timestamp", ascending: false)],
            predicate: .init(format: "card == %@", card))
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Transactions")
                Spacer()
                Button {
                    shouldPresentSheet.toggle()
                } label: {
                    Text("+ Transaction")
                        .padding(EdgeInsets(top: 5, leading: 9, bottom: 5, trailing: 9))
                        .foregroundColor(Color(.systemBackground))
                        .background(Color(.label))
                        .cornerRadius(5)
                }
            }
            .padding(.bottom, 15)
            
            let columns: [GridItem] = [
                .init(.fixed(100), spacing: 16, alignment: .leading),
                .init(.fixed(150), spacing: 16, alignment: .leading),
                .init(.flexible(minimum: 100, maximum: 500), spacing: 16, alignment: .leading),
                .init(.fixed(200), spacing: 16, alignment: .trailing)
            ]
            
            LazyVGrid(columns: columns) {
                HStack {
                    Text("Date")
                    Image(systemName: "arrow.up.arrow.down")
                }
                Text("Photo / Receipt")
                HStack {
                    Text("Name")
                    Image(systemName: "arrow.up.arrow.down")
                }
                HStack {
                    Text("Amount")
                    Image(systemName: "arrow.up.arrow.down")
                }
            }
            .foregroundColor(.secondary)
            .font(.system(size: 20))
            
            LazyVStack(spacing: 0) {
                ForEach(fetchedRequest.wrappedValue) { transaction in
                    VStack(spacing: 0) {
                        Divider()
                        if let index = fetchedRequest.wrappedValue.firstIndex(of: transaction) {
                            LazyVGrid(columns: columns) {
                                Group {
                                    if let date = transaction.timestamp {
                                        Text(DateFormatter.shortFormat.string(from: date))
                                    }
                                    if let imageData = transaction.photoData,
                                       let uiImage = UIImage(data: imageData) {
                                        Image(uiImage: uiImage)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 70)
                                            .cornerRadius(5)
                                        
                                    } else {
                                        Text("No Photo")
                                    }
                                    Text(transaction.name ?? "")
                                        .fontWeight(.bold)
                                    Text(String(format: "%.2f", transaction.amount))
                                        .fontWeight(.bold)
                                        .foregroundColor(.red)
                                }
                                .frame(height: 80)
                                .font(.system(size: 18))
                                .multilineTextAlignment(.leading)
                            }
                            .background(index % 2 == 0 ? Color(.systemBackground) : Color(.init(white: 0, alpha: 0.03)))
                        }
                    }
                }
            }
        }
        .padding(.horizontal)
        .font(.title2)
        
        //SHEET
        .sheet(isPresented: $shouldPresentSheet) { AddTransactionFormView(card) }
    }
}

struct TransactionGrid_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsGridView(Card.init())
    }
}
