//
//  TransactionView.swift
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

struct TransactionView: View {
    
    let transaction: CardTransaction
    
    @State var refreshID = UUID()
    
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
                            //
                        } label: {
                            Image(systemName: "ellipsis")
                                .font(.system(size: 24, weight: .bold))
                        }
                        .padding(EdgeInsets(top: 6, leading: 8, bottom: 4, trailing: 0))
                        
                        Text(String(format: "$%.2f",transaction.amount))
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
    }
    
}
