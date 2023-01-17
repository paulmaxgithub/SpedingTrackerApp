//
//  MainView.swift
//  SpedingTrackerApp
//
//  Created by PaulmaX on 16.01.23.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        NavigationView {
            
            ScrollView {
                
                TabView {
                    ForEach(0..<5) { _ in
                        CreditCardView()
                            .padding(.bottom, 50)
                    }
                }
                .frame(height: 280)
                .tabViewStyle(.page(indexDisplayMode: .always))
                .indexViewStyle(.page(backgroundDisplayMode: .always))
            }
            .navigationTitle("Credit Cards")
            .navigationBarItems(trailing: AddCardViewButton())
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
