//
//  AddCardFormView.swift
//  SpedingTrackerApp
//
//  Created by PaulmaX on 17.01.23.
//

import SwiftUI

struct AddCardFormView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
            }
            .navigationTitle("Add Credit Card")
            .navigationBarItems(leading: Button(action: {
                dismiss()
            }, label: {
                Text("Cancel")
            }))
        }
    }
}

struct AddCardFormView_Previews: PreviewProvider {
    static var previews: some View {
        AddCardFormView()
    }
}
