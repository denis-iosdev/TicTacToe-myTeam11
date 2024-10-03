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
    
    @Environment(\.presentationMode) private var presentationMode
    let title: String
    let leftButtonState: ToolBarLeftItemState
    let rightButtonHiddeb: Bool
    var leftAction: VoidBlock?
    var rightAction: VoidBlock?
    
    // MARK: - init
    
    init(
        title: String = "",
        leftButtonState: ToolBarLeftItemState = .back,
        rightButtonHiddeb: Bool = true,
        leftAction: VoidBlock? = nil,
        rightAction: VoidBlock? = nil
    ) {
        self.title = title
        self.leftButtonState = leftButtonState
        self.rightButtonHiddeb = rightButtonHiddeb
        self.leftAction = leftAction
        self.rightAction = rightAction
    }
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            leftButton
        }
        ToolbarItem(placement: .principal) {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
        }
        ToolbarItem(placement: .topBarTrailing) {
            if !rightButtonHiddeb {
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
            Image(uiImage: .settingIcon)
                .padding(.bottom, 4)
        }
    }
}
