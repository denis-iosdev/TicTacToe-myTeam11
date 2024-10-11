//
//  MusicView.swift
//  TicTacToe
//
//  Created by Иван Семикин on 04/10/2024.
//

import SwiftUI

struct MusicView: View {
    @Binding var isMusicEnabled: Bool
    @Binding var choosedGenre: MusicGenres
    
    @State private var currentIndex: Int = 0
    
    private let allMusicGenres = MusicGenres.allCases
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Toggle(isOn: $isMusicEnabled) {
                    Text("Music")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(.appBlack)
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
                        choosedGenre = allMusicGenres[currentIndex]
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.largeTitle)
                            .foregroundStyle(Color.buttonDarkBackground)
                            .opacity(currentIndex == 0 ? 0.3 : 1)
                    }
                    .disabled(currentIndex == 0)
                    
                    Spacer()
                    
                    Text(allMusicGenres[currentIndex].rawValue.localized)
                        .font(.system(size: 20, weight: .medium))
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.appBlack)
                        .animation(.interactiveSpring(), value: currentIndex)
                    
                    Spacer()
                    
                    Button {
                        if currentIndex < allMusicGenres.count - 1 {
                            currentIndex += 1
                        }
                        choosedGenre = allMusicGenres[currentIndex]
                    } label: {
                        Image(systemName: "chevron.right")
                            .font(.largeTitle)
                            .foregroundStyle(Color.buttonDarkBackground)
                            .opacity(currentIndex == allMusicGenres.count - 1 ? 0.3 : 1)
                    }
                    .disabled(currentIndex == allMusicGenres.count - 1)
                }
                .padding()
                .background(Color.buttonLightBackground)
                .cornerRadius(30)
            }
        }
        .onAppear {
            if let savedGenreIndex = allMusicGenres.firstIndex(of: choosedGenre) {
                currentIndex = savedGenreIndex
            }
        }
    }
}

#Preview {
    MusicView(isMusicEnabled: .constant(true), choosedGenre: .constant(.classic))
}
