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
    func setSong(_ song: MusicGenres)
}

class AudioPlayer: AudioPlayerProtocol, ObservableObject {
    
    var player: AVAudioPlayer?
    private var song: MusicGenres = .classic
    
    func playSound() {
        if let url = Bundle.main.url(forResource: song.songName, withExtension: nil) {
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
    
    func setSong(_ song: MusicGenres) {
        self.song = song
    }
}
