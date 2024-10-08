//
//  LanguageManager.swift
//  TicTacToe
//
//  Created by Даниил Сивожелезов on 08.10.2024.
//

import Foundation

class LanguageManager: ObservableObject {
    var currentLanguage: String {
        didSet {
            UserDefaults.standard.set(currentLanguage, forKey: "selectedLanguage")
        }
    }
    
    init() {
        self.currentLanguage = UserDefaults.standard.string(forKey: "selectedLanguage") ?? "en"
    }
}
