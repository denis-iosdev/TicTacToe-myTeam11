//
//  AudioPlayer.swift
//  TicTacToe
//
//  Created by Игорь Пачкин on 2/10/24.
//

import SwiftUI
import AVFoundation

protocol AudioPlayerProtocol {
    func playSound()
    func stopSound()
}

class AudioPlayer: AudioPlayerProtocol {
    var player: AVAudioPlayer?
    
    // Функция для инициализации и запуска аудиоплеера
    func playSound() {
        // Убедитесь, что файл аудио существует в проекте
        if let url = Bundle.main.url(forResource: "Jazz", withExtension: "mp3") {
            do {
                // Инициализация аудиоплеера
                player = try AVAudioPlayer(contentsOf: url)
                player?.numberOfLoops = -1 // Бесконечный повтор
                player?.play() // Воспроизведение аудио
            } catch {
                print("Ошибка воспроизведения звука: \(error.localizedDescription)")
            }
        }
    }
    
    // Функция для остановки воспроизведения
    func stopSound() {
        player?.stop()
    }
}