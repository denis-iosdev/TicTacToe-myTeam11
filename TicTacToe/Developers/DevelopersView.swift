//
//  DevelopersView.swift
//  TicTacToe
//
//  Created by Даниил Сивожелезов on 11.10.2024.
//

import SwiftUI
import NavigationBackport

struct Developer: Identifiable {
    let id = UUID()
    let name: String
    let image: String
    let url: String
}

struct DevelopersView: View {
    @EnvironmentObject var navigator: PathNavigator
    let developers = [
        Developer(name: "Denis Gindulin".localized, image: "denis", url: "https://t.me/denisgindulin"),
        Developer(name: "Daniil Sivozhelezov".localized, image: "daniil", url: "https://t.me/Da_N_ii_l"),
        Developer(name: "Ivan Semikin".localized, image: "ivan", url: "https://t.me/ivan_semik1n"),
        Developer(name: "Igor Pachkin".localized, image: "igor", url: "https://t.me/IgorP1901"),
        Developer(name: "Pavel Gritskov".localized, image: "pasha", url: "https://t.me/pavel_gr_dev"),
    ]
    
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            VStack(spacing: 21) {
                ForEach(developers) { developer in
                    DeveloperView(name: developer.name, image: developer.image, urlString: developer.url)
                }
                
                Spacer()
                HStack {
                    Text("Developed for".localized)
                        .foregroundStyle(.appBlack)
                    Link("DevRush", destination: URL(string: "https://t.me/dev_rush")!)
                    Image(.devRushLogo)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                }
            }
            .padding(.horizontal, 21)
            .padding(.vertical, 16)
        }
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolBarNavigationItems(
                title: "Developers".localized,
                leftAction: { navigator.pop() }
             )
        }
    }
}

struct DeveloperView: View {
    let name: String
    let image: String
    let urlString: String
    
    var body: some View {
        HStack {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 70, height: 70)
                .clipShape(Circle())
            
            Text(name)
                .font(.system(size: 16))
                .frame(maxWidth: .infinity, alignment: .leading)
                .leaderboardText(index: 1)
                .clipShape(RoundedRectangle(cornerRadius: 30))
            
            Link(destination: URL(string: urlString)!) {
                Image(systemName: "arrowshape.turn.up.right.fill")
                    .foregroundStyle(.appBlack)
            }
        }
    }
}

#Preview {
    DevelopersView()
}
