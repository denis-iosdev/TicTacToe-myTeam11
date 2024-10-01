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

enum NavigationBarBackgroundColor {
    case white
    case main
}

struct CustomNavigationView: View {
    
    @Environment(\.presentationMode) var presentationMode
    let title: String
    let leftButtonState: CustomLeftButton
    let showRightButton: Bool
    let backgroundColor: NavigationBarBackgroundColor
    var rightButtonAction: VoidBlock?
    var leftButtonAction: VoidBlock?
    
    
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
            switch backgroundColor {
            case .white:
                Color.white.ignoresSafeArea(edges: .top)
            case .main:
                Color.blue.ignoresSafeArea(edges: .top)
            }
        }
    }
}

#Preview {
    VStack {
        CustomNavigationView(
            title: "Title",
            leftButtonState: .back,
            showRightButton: false,
            backgroundColor: .main
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
