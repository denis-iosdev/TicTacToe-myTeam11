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
            button(leftButtonState.image, action: leftAction)
        }
        ToolbarItem(placement: .principal) {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
        }
        ToolbarItem(placement: .topBarTrailing) {
            if !rightButtonHiddeb {
                button(.settingButtonIcon, action: rightAction)
            }
        }
    }
    
    private func button(_ uiImage: UIImage, action: VoidBlock?) -> some View {
        Button {
            switch leftButtonState {
            case .back:
                presentationMode.wrappedValue.dismiss()
            case .help:
                action?()
            }
        } label: {
            Image(uiImage: uiImage)
                .padding(.bottom, 4)
        }
    }
}
