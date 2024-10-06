//
//  WinningLineView.swift
//  TicTacToe
//
//  Created by Даниил Сивожелезов on 01.10.2024.
//

import SwiftUI

struct WinningLineView: View {
    let line: (start: CGPoint, end: CGPoint) // Координаты для линии

    @State private var animateLine: CGFloat = 0 // Переменная для контроля анимации

    // Создание и настройка линии
    var body: some View {
        GeometryReader { geometry in
            let startPoint = CGPoint(x: line.start.x * geometry.size.width, y: line.start.y * geometry.size.height)
            let endPoint = CGPoint(x: line.end.x * geometry.size.width, y: line.end.y * geometry.size.height)

            Path { path in
                path.move(to: startPoint)
                path.addLine(to: endPoint)
            }
            .trim(from: 0, to: animateLine) // Используем trim для анимации
            .stroke(Color.basicBlue, style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
            .animation(.easeInOut(duration: 1.0), value: animateLine) // Настройка анимации
            .onAppear {
                self.animateLine = 1.0 // Запуск анимации при появлении
            }
        }
    }
}
