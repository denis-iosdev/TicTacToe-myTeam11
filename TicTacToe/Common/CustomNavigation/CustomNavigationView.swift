//
//  CustomNavigationView.swift
//  TicTacToe
//
//  Created by Pavel Gritskov on 30.09.24.
//

import SwiftUI

struct CustomNavigationView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State private var title: String = "Title" //""
    @State private var showBackbutton: Bool = true
    @State private var showRightButton: Bool = true
    
    var body: some View {
        HStack {
            if showBackbutton {
                backButton
            }
            Spacer()
            navigationTitle
            Spacer()
            if showRightButton {
                rightButton
            }
        }
        .font(.headline)
        .imageScale(.large)
        .accentColor(.white)
        .padding()
        .background {
            Color.white.ignoresSafeArea(edges: .top)
        }
    }
}

#Preview {
    VStack {
        CustomNavigationView()
        
        Spacer()
    }
}

extension CustomNavigationView {
    
    private var backButton: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Image(uiImage: UIImage.backButtonIcon)
        }
    }
    
    private var rightButton: some View {
        Button {
            // action
        } label: {
            Image(uiImage: UIImage.settingIcon)
        }
    }
    
    private var navigationTitle: some View {
        VStack {
            Text(title)
                .font(.title)
                .fontWeight(.semibold)
//            Text("Sub title")
        }
    }
    
}
