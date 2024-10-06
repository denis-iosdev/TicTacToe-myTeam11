//
//  TestNativeNavAppView.swift
//  TicTacToe
//
//  Created by Pavel Gritskov on 02.10.24.
//

import SwiftUI

// onboarding
// --> gameMode (fullScreenCover)
// --> help (fullScreenCover)
// --> setting (fullScreenCover)

// gameMode with NavigationView

// --> (solo) game (NavigationLink with action)
// --> (together) game (NavigationLink with action)
// --> leaderboard (NavigationLink)
// --> difflvl (fullScreenCover)
// --> setting (fullScreenCover)
// game
// --> result (NavigationLink)
// <-- root ()


struct TestNativeNavAppView: View {
    var body: some View {
//        NavigationView {
            TestNativeNextView01()
//        }
    }
}

// MARK: - next 01

struct TestNativeNextView01: View {
    
    @State private var gemeMod = false
    
    var body: some View {
//        NavigationView {
            ZStack {
                Color.green
                VStack(spacing: 20) {
                    NavigationLink {
                        TestNativeNextView02()
                    } label: {
                        Text("link gemeMod")
                            .font(.title)
                    }
                    
                    Button {
                        gemeMod.toggle()
                    } label: {
                        Text("fullScreen gemeMod")
                    }
                }
            }
            .fullScreenCover(isPresented: $gemeMod) {
                TestNativeNextView02()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolBarNavigationItems(title: "Onbording")
            }
//        }
    }
}

// MARK: - next 02

struct TestNativeNextView02: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showRootView: Bool = false
    @State private var showSettingView: Bool = false
    @State private var sectionTag: String? = nil
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.red
                VStack {
                    NavigationLink(isActive: $showRootView) {
                        TestNativeNextView03(showRootView: $showRootView)
                    } label: {
                        Text("GamePlay")
                            .font(.title)
                    }
                    NavigationLink(tag: "tag1", selection: $sectionTag) {
                        TestNativeNextView06(section: $sectionTag)
                    } label: { EmptyView() }
                    
                    Button {
                        sectionTag = "tag1"
                    } label: {
                        Text("show tag 1")
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolBarNavigationItems(
                    title: "GemeMod",
                    leftButtonState: .help,
                    rightButtonHidden: false,
                    leftAction: {
                    presentationMode.wrappedValue.dismiss()
                }, rightAction: {
                    showSettingView.toggle()
                })
            }
            .fullScreenCover(isPresented: $showSettingView) {
                TestNativeNextView05()
            }
        }
    }
}

// MARK: - next 03

struct TestNativeNextView03: View {
    
    @Binding var showRootView: Bool
    
    var body: some View {
        ZStack {
            Color.white
            NavigationLink {
                TestNativeNextView04(showRootView: $showRootView)
            } label: {
                Text("Result")
                    .font(.title)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolBarNavigationItems(title: "GamePlay")
        }
    }
}

// MARK: - next 04

struct TestNativeNextView04: View {
    
    @Binding var showRootView: Bool
    
    var body: some View {
        ZStack {
            Color.orange
            Button {
                showRootView.toggle()
            } label: {
                Text("go to root")
                    .font(.title)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolBarNavigationItems(title: "Result")
        }
    }
}

// MARK: - next 05 (Setting)

struct TestNativeNextView05: View {
    
//    @Binding var showRootView: Bool
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Color.orange
            Button {
//                showRootView.toggle()
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("go to root")
                    .font(.title)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolBarNavigationItems(title: "Setting")
        }
    }
}

// MARK: - next 06

struct TestNativeNextView06: View {
    
    @Binding var section: String?
    
    var body: some View {
        ZStack {
            Color.gray
            NavigationLink {
                TestNativeNextView07(section: $section)
            } label: {
                Text("Tag 2")
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolBarNavigationItems(title: "tag1")
        }
    }
}

// MARK: - next 07

struct TestNativeNextView07: View {
    
    @Binding var section: String?
    
    var body: some View {
        ZStack {
            Color.gray
            Button {
                section = nil
            } label: {
                Text("go to root")
                    .font(.title)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolBarNavigationItems(title: "tag2")
        }
    }
}

#Preview {
//    TestNativeNavAppView()
    TestNativeNextView01()
//    TestNativeNextView02()
}

