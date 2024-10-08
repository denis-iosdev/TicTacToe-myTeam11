//
//  TestNavigationBar.swift
//  TicTacToe
//
//  Created by Pavel Gritskov on 02.10.24.
//

import SwiftUI

struct ToolBarNavigationItems: ToolbarContent {
    
    enum ToolBarLeftItemState {
        case back
        case help
        
        var image: UIImage {
            switch self {
            case .back:
                    .backButtonIcon
            case .help:
                    .helpIcon
            }
        }
    }
    
    enum ToolBarRightItemState {
        case settings
        case basket
        
        var image: UIImage {
            switch self {
            case .settings:
                    .settingIcon
            case .basket:
                    .basket
            }
        }
    }
    
    @Environment(\.presentationMode) private var presentationMode
    let title: String
    let leftButtonState: ToolBarLeftItemState
    let rightButtonState: ToolBarRightItemState
    let rightButtonHidden: Bool
    var leftAction: VoidBlock?
    var rightAction: VoidBlock?
    
    // MARK: - init
    
    init(
        title: String = "",
        leftButtonState: ToolBarLeftItemState = .back,
        rightButtonState: ToolBarRightItemState = .settings,
        rightButtonHidden: Bool = true,
        leftAction: VoidBlock? = nil,
        rightAction: VoidBlock? = nil
    ) {
        self.title = title
        self.leftButtonState = leftButtonState
        self.rightButtonState = rightButtonState
        self.rightButtonHidden = rightButtonHidden
        self.leftAction = leftAction
        self.rightAction = rightAction
    }
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            leftButton
        }
        ToolbarItem(placement: .principal) {
            Text(title)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundStyle(.appBlack)
        }
        ToolbarItem(placement: .topBarTrailing) {
            if !rightButtonHidden {
                rightButton
            }
        }
    }
    
    private var leftButton: some View {
        Button {
            switch leftButtonState {
            case .back:
                presentationMode.wrappedValue.dismiss()
            case .help:
                leftAction?()
            }
        } label: {
            Image(uiImage: leftButtonState.image)
                .padding(.bottom, 4)
        }
    }
    
    private var rightButton: some View {
        Button {
            rightAction?()
        } label: {
            switch rightButtonState {
            case .settings:
                Image(uiImage: rightButtonState.image)
                    .padding(.bottom, 4)
            case .basket:
                Image(uiImage: rightButtonState.image)
                    .resizable()
                    .scaledToFit()
                    .padding(.bottom, 4)
                    .frame(width: 36, height: 32)
            }
            
        }
    }
}
