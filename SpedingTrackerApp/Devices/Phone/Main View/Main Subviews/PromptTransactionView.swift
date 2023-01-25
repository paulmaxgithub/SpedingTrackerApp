//
//  EmptyPromtTransactionView.swift
//  SpedingTrackerApp
//
//  Created by PaulmaX on 20.01.23.
//

import SwiftUI

struct PromptTransactionView: View {
    
    @State private var addTransactionFormShown  = false
    @State private var shouldShowFilterSheet    = false
    @State private var selectedCategories = Set<TransactionCategory>()
    
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
            if fetchedRequest.wrappedValue.isEmpty {
                Text("Get started by adding your transaction")
                    .padding(.horizontal, 48)
                    .multilineTextAlignment(.center)
                addTransactionButton
            } else {
                HStack {
                    Spacer()
                    addTransactionButton
                    filterButton
                }
                .padding(.horizontal)
                
                ForEach(filterTransactions(selectedCategories)) { transaction in
                    CardTransactionView(transaction: transaction)
                }
            }
        }
        .font(.system(size: 15, weight: .semibold))
        
        //FULL SCREEN COVERS
        .fullScreenCover(isPresented: $addTransactionFormShown) { AddTransactionFormView(card) }
        .sheet(isPresented: $shouldShowFilterSheet) { FilterSheetView(selectedCategories: selectedCategories,
                                                                      filterDidSave: { selectedCategories = $0 }) }
    }
    
    private var addTransactionButton: some View {
        Button {
            addTransactionFormShown.toggle()
        } label: {
            Text("+ Transaction")
                .padding(EdgeInsets(top: 10, leading: 14, bottom: 10, trailing: 14))
                .foregroundColor(Color(.systemBackground))
                .background(Color(.label))
                .cornerRadius(5)
        }
    }
    
    private var filterButton: some View {
        Button {
            shouldShowFilterSheet.toggle()
        } label: {
            Text("〶 Filter")
                .padding(EdgeInsets(top: 10, leading: 14, bottom: 10, trailing: 14))
                .foregroundColor(Color(.systemBackground))
                .background(Color(.label))
                .cornerRadius(5)
        }
    }

    private func filterTransactions(_ selectedCategories: Set<TransactionCategory>) -> [CardTransaction] {
        
        if selectedCategories.isEmpty { return Array(fetchedRequest.wrappedValue) }
        
        return fetchedRequest.wrappedValue.filter { transaction in
            
            var shouldKeep = false
            
            if let categories = transaction.categories as? Set<TransactionCategory> {
                categories.forEach { category in
                    if selectedCategories.contains(category) { shouldKeep = true }
                }
            }
            
            return shouldKeep
        }
    }
}
