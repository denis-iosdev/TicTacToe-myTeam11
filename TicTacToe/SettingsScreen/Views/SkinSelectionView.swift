//
//  SkinSelectionView.swift
//  TicTacToe
//
//  Created by Иван Семикин on 02/10/2024.
//

import SwiftUI

struct SkinSelectionView: View {
    @Binding var selectedXSkin: Int
    @Binding var selectedOSkin: Int
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
            ForEach(1..<7) { skinNumber in
                let isChoosedSkin = skinNumber == selectedXSkin
                
                VStack {
                    HStack {
                        Image("Xskin\(skinNumber)")
                        Image("Oskin\(skinNumber)")
                    }
                    
                    Button {
                        selectedXSkin = skinNumber
                        selectedOSkin = skinNumber
                    } label: {
                        Text(isChoosedSkin ? "Picked" : "Choose")
                            .padding(10)
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(isChoosedSkin ? .white : .black)
                            .background(isChoosedSkin
                                        ? Color.buttonDarkBackground
                                        : Color.buttonLightBackground)
                            .clipShape(.capsule)
                            .padding(.top)
                    }
                }
                .padding()
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .shadow(color: Color.black.opacity(0.15), radius: 10)
            }
            .padding(10)
        }
    }
}

#Preview {
    SkinSelectionView(selectedXSkin: .constant(1), selectedOSkin: .constant(1))
}
