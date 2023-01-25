//
//  TransactionsGridView.swift
//  SpedingTrackerApp
//
//  Created by PaulmaX on 25.01.23.
//

import SwiftUI

struct TransactionsGridView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Transactions")
                Spacer()
                Button {
                    //
                } label: {
                    Text("+ Transaction")
                }
            }
            
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
        }
        .font(.largeTitle)
        .padding(.horizontal)
    }
}

struct TransactionGrid_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsGridView()
    }
}
