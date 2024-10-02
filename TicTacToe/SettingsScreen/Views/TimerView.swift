//
//  TimerView.swift
//  TicTacToe
//
//  Created by Иван Семикин on 02/10/2024.
//

import SwiftUI

struct TimerView: View {
    @Binding var isTimerEnabled: Bool
    @Binding var timerSeconds: Int
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Toggle(isOn: $isTimerEnabled) {
                    Text("Game Time")
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                }
                .padding()
                .background(Color.buttonLightBackground)
                .cornerRadius(30)
                
            }
            
            if isTimerEnabled {
                VStack {
                    Text("Duration")
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                    
                    HStack() {
                        Text("\(formattedTime(seconds: timerSeconds))")
                            .font(.system(size: 20))
                            .fontWeight(.semibold)
                        
                        Stepper("", value: $timerSeconds, in: 15...300, step: 15)
                    }
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
    
    private func formattedTime(seconds: Int) -> String {
        let minute = seconds / 60
        let seconds = seconds % 60
        return "\(minute) min. \(seconds) sec."
    }
}

#Preview {
    TimerView(isTimerEnabled: .constant(false), timerSeconds: .constant(60))
}
