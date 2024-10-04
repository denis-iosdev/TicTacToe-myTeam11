//
//  MusicView.swift
//  TicTacToe
//
//  Created by Иван Семикин on 04/10/2024.
//

import SwiftUI

struct MusicView: View {
    @Binding var isMusicEnabled: Bool
    @State private var currentIndex: Int = 0
    let items = ["Classical", "Instrumentals", "Nature"]
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Toggle(isOn: $isMusicEnabled) {
                    Text("Music")
//                        .padding()
                        .font(.system(size: 20, weight: .semibold))
                }
                .tint(.buttonDarkBackground)
                .padding()
                .background(Color.buttonLightBackground)
                .cornerRadius(30)
            }
            
            if isMusicEnabled {
                HStack {
                    Button {
                        if currentIndex > 0 {
                            currentIndex -= 1
                        }
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.largeTitle)
                            .foregroundStyle(Color.buttonDarkBackground)
                            .opacity(currentIndex == 0 ? 0.3 : 1)
                    }
                    .disabled(currentIndex == 0)
                    
                    Spacer()
                    
                    Text(items[currentIndex])
                        .font(.system(size: 20, weight: .medium))
                        .frame(maxWidth: .infinity)
                        .animation(.interactiveSpring(), value: currentIndex)
                    
                    Spacer()
                    
                    Button {
                        if currentIndex < items.count - 1 {
                            currentIndex += 1
                        }
                    } label: {
                        Image(systemName: "chevron.right")
                            .font(.largeTitle)
                            .foregroundStyle(Color.buttonDarkBackground)
                            .opacity(currentIndex == items.count - 1 ? 0.3 : 1)
                    }
                    .disabled(currentIndex == items.count - 1)
                }
                .padding()
                .background(Color.buttonLightBackground)
                .cornerRadius(30)
            }
        }
        .padding()
        .background(.white)
        .cornerRadius(30)
        .shadow(color: Color.black.opacity(0.15), radius: 10)
    }
}

#Preview {
    MusicView(isMusicEnabled: .constant(true))
}
