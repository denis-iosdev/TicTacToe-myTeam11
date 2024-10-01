//
//  CustomNavigationView.swift
//  TicTacToe
//
//  Created by Pavel Gritskov on 30.09.24.
//

import SwiftUI

enum CustomLeftButton {
    case back
    case help
    case hidden
}

struct CustomNavigationView: View {
    
    @Environment(\.presentationMode) var presentationMode
    let title: String
    let leftButtonState: CustomLeftButton
    let showRightButton: Bool
    var rightButtonAction: VoidBlock?
    var leftButtonAction: VoidBlock?
    @State private var isWhiteBackground: Bool = false
    
    var body: some View {
        HStack {
            
            switch leftButtonState {
            case .back:
                backButton
            case .help:
                helpButton
            case .hidden:
                emptyElement
            }
            
            Spacer()
            navigationTitle
            Spacer()
            
            if showRightButton {
                rightButton
            } else {
                emptyElement
            }
        }
        .font(.headline)
        .imageScale(.large)
        .accentColor(.white)
        .padding()
        .background {
            return isWhiteBackground
            ? Color.white.ignoresSafeArea(edges: .top)
            : Color.blue.ignoresSafeArea(edges: .top)
        }
    }
}

#Preview {
    VStack {
        CustomNavigationView(
            title: "Title",
            leftButtonState: .back,
            showRightButton: false
        )
        Spacer()
    }
}

extension CustomNavigationView {
    
    private var emptyElement: some View {
        Rectangle()
            .frame(width: 36, height: 36)
            .foregroundStyle(.clear)
    }
    
    private var backButton: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Image(uiImage: UIImage.backButtonIcon)
        }
    }
    
    private var helpButton: some View {
        Button {
            isWhiteBackground = true
            leftButtonAction?()
        } label: {
            Image(uiImage: UIImage.helpIcon)
        }
    }
    
    private var rightButton: some View {
        Button {
            rightButtonAction?()
        } label: {
            Image(uiImage: UIImage.settingIcon)
        }
    }
    
    private var navigationTitle: some View {
        VStack {
            Text(title)
                .font(.title)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                
        }
    }
}
