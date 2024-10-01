//
//  TestAppContentView.swift
//  TicTacToe
//
//  Created by Pavel Gritskov on 01.10.24.
//

import SwiftUI

// статья по нативной навигации
// https://habr.com/ru/articles/652593/
// По этому видео делалась навигация
// https://www.youtube.com/watch?v=aIDT4uuMLHc&ab_channel=SwiftfulThinking

struct TestAppContentView: View {
    
    @State private var showSettingView: Bool = false
    @State private var showHelpView: Bool = false
    @State private var activateRootLink: Bool = false
    
    var body: some View {
        CustomNavView(
            rightButtonAction: showSettingViewAction,
            leftButtonAction: showshowHelpViewAction
        ) {
            
            ZStack {
                Color.gray.opacity(0.3).ignoresSafeArea()
                VStack(spacing: 10) {
                    // show setting view
                    CustomNavigationLinkWithAction(action: $showSettingView) {
                        TestSettingView()
                    } label: {
                        EmptyView()
                    }
                    // show help view
                    CustomNavigationLinkWithAction(action: $showHelpView) {
                        TestHelpView()
                    } label: {
                        EmptyView()
                    }
                    // show select view
                    CustomNavigationLink {
                        TestSelectView()
                    } label: {
                        Text("Select view")
                    }
                    // back to the root
                    CustomNavigationLinkWithAction(action: $activateRootLink) {
                        TestFirstView(activateRootLink: $activateRootLink)
                    } label: {
                        Text("show first view")
                    }
                }
            }
            .customNavBarItems(
                title: "RootView",
                leftButtonState: .help,
                rightButtonHidden: false,
                navBarBackgroundColor: .onboarding
            )
        }
    }
    
    private func showSettingViewAction() {
        showSettingView.toggle()
    }
    
    private func showshowHelpViewAction() {
        showHelpView.toggle()
    }
}

// MARK: - TestSelectView

struct TestSelectView: View {
    var body: some View {
        ZStack {
            Color.blue.opacity(0.3)
            VStack {
                Text("Select view")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.red)
            }
        }
        .customNavigationTitle("Select view")
    }
}

// MARK: - TestSettingView

struct TestSettingView: View {
    var body: some View {
        ZStack {
            Color.blue.opacity(0.3)
            VStack {
                Text("TestSettingView")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.yellow)
            }
        }
        .customNavigationTitle("TestSettingView")
    }
}

// MARK: - TestHelpView

struct TestHelpView: View {
    var body: some View {
        ZStack {
            Color.green.opacity(0.3)
            VStack {
                Text("TestHelpView")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.yellow)
            }
        }
        .customNavigationTitle("TestHelpView")
    }
}

// MARK: - TestFirstView

struct TestFirstView: View {
    
    @Binding var activateRootLink: Bool
    
    var body: some View {
        ZStack {
            Color.brown
            VStack {
                CustomNavigationLink {
                    TestSecondView(activateRootLink: $activateRootLink)
                } label: {
                    Text("Show second view")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.white)
                }
            }
        }
        .customNavigationTitle("TestFirstView")
    }
}

// MARK: - TestSecondView

struct TestSecondView: View {
    
    @Binding var activateRootLink: Bool
    
    var body: some View {
        ZStack {
            Color.brown
            VStack {
                Button {
                    activateRootLink.toggle()
                } label: {
                    Text("go to root")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.white)
                }
            }
        }
        .customNavigationTitle("TestSecondView")
    }
}

#Preview {
    TestAppContentView()
}
