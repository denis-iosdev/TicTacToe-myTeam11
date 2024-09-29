//
//  ContentView.swift
//  TicTacToe
//
//  Created by Денис Гиндулин on 29.09.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var name = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Exit text:", text: $name)
                Text("Enter text: \(name)")
            }
            .navigationTitle("SwiftUI")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView()
}
