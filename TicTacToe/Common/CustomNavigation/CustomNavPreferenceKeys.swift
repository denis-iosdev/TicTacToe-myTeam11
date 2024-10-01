//
//  CustomNavPreferenceKeys.swift
//  TicTacToe
//
//  Created by Pavel Gritskov on 01.10.24.
//

import SwiftUI

struct CustomNavBarTitlePreferenceKeys: PreferenceKey {
    
    static var defaultValue: String = ""
    
    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
}

struct CustomNavBarBackLeftButtonStatePreferenceKeys: PreferenceKey {
    
    static var defaultValue: CustomLeftButton = .back
    
    static func reduce(value: inout CustomLeftButton, nextValue: () -> CustomLeftButton) {
        value = nextValue()
    }
}

struct CustomNavBarRightButtonHiddenPreferenceKeys: PreferenceKey {
    
    static var defaultValue: Bool = true
    
    static func reduce(value: inout Bool, nextValue: () -> Bool) {
        value = nextValue()
    }
}

extension View {
    
    func customNavigationTitle(_ title: String) -> some View {
        preference(key: CustomNavBarTitlePreferenceKeys.self, value: title)
    }
    
    func customNavigationLeftButtonState(_ value: CustomLeftButton) -> some View {
        preference(key: CustomNavBarBackLeftButtonStatePreferenceKeys.self, value: value)
    }
    
    func customNavigationRightButtonHidden(_ value: Bool) -> some View {
        preference(key: CustomNavBarRightButtonHiddenPreferenceKeys.self, value: value)
    }
    
    func customNavBarItems(
        title: String = "",
        leftButtonState: CustomLeftButton = .back,
        rightButtonHidden: Bool = true
    ) -> some View {
        self
            .customNavigationTitle(title)
            .customNavigationLeftButtonState(leftButtonState)
            .customNavigationRightButtonHidden(rightButtonHidden)
    }
}
