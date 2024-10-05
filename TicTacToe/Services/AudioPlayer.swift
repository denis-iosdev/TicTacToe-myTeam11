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

class AudioPlayer: AudioPlayerProtocol, ObservableObject {
    
    var player: AVAudioPlayer?
    @ObservedObject var storageManager: StorageManager

    init(storageManager: StorageManager) {
        self.storageManager = storageManager
    }
    
    func playSound() {
        // Проверяем, включена ли музыка в настройках
        guard storageManager.isMusicEnabled else {
            print("Музыка выключена в настройках")
            return
        }
        
        let genre = storageManager.settings.choosedGenre
        let songName = genre.songName
        
        if let url = Bundle.main.url(forResource: songName, withExtension: nil) {
            do {
                player = try AVAudioPlayer(contentsOf: url)
                player?.numberOfLoops = -1
                player?.volume = 0.0 // Начинаем с нулевой громкости
                player?.play()
                // Плавное нарастание громкости
                player?.setVolume(1.0, fadeDuration: 2.0)
            } catch {
                print("Ошибка воспроизведения звука: \(error.localizedDescription)")
            }
        }
    }
    
    
    // Плавное затухание музыки
    func stopSound() {
        let duration: TimeInterval = 1.0
        player?.setVolume(0.0, fadeDuration: duration)
        
        // Остановка музыки после завершения затухания
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            self.player?.stop()
        }
    }
}
