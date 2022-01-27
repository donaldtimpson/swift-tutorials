//
//  EmojiMemorizeGame.swift
//  Memorize
//
//  Created by Donald Timpson on 1/26/22.
//

import SwiftUI

class EmojiMemorizeGame: ObservableObject {
    typealias Card = MemorizeGame<String>.Card
    
    private let theme: EmojiTheme
    private let difficulty: Difficulty
    @Published private var model: MemorizeGame<String>
    
    init(theme: EmojiTheme, difficulty: Difficulty) {
        let emojis = Array(theme.emojis).shuffled()
        self.theme = theme
        self.difficulty = difficulty
        self.model = MemorizeGame(numberOfPairs: difficulty.numberOfPairs) { index in String(emojis[index]) }
    }
    
    // MARK: - Data Access
    
    var cards: [Card] { model.cards }
    var title: String { theme.title }
    var color: Color { theme.color }
    
    // MARK: - Intent(s)
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func newGame() {
        let emojis = Array(theme.emojis).shuffled()
        self.model = MemorizeGame(numberOfPairs: difficulty.numberOfPairs) { index in String(emojis[index]) }
    }
}

enum EmojiTheme: CaseIterable, Identifiable {
    case halloween
    case animals
    case plants
    
    var id: String { title }
    
    var pairsOfCards: Int {
        switch self {
        case .halloween:    return 6
        case .animals:      return 10
        case .plants:       return 15
        }
    }
    
    var color: Color {
        switch self {
        case .halloween:    return .orange
        case .animals:      return .red
        case .plants:       return .green
        }
    }
    
    var title: String {
        switch self {
        case .halloween:    return "Halloween"
        case .animals:      return "Animals"
        case .plants:       return "Plants"
        }
    }
    
    var emojis: String {
        switch self {
        case .halloween:    return "💫🕸🕷👾🍂🍁💥☄️🔥🧚⭐️🧟‍♂️👹🌙⚡️☠️💀👻😈🦇👿👺🎃🤖👽🤡🧛🏻‍♂️🧙🏻‍♂️🦴⚔️"
        case .animals:      return "🐶🐱🐭🐹🐰🦊🐻🐼🐻‍❄️🐨🐯🦁🐮🐷🐸🐵🐔🐤🐺🐗🐴🦄"
        case .plants:       return "🌵🌲🌳🌴🪵🌱🌿☘️🍀🎍🪴🎋🍃🍂🍁🌾💐🌷🌹🥀🌺🌸🌼🌻"
        }
    }
}

enum Difficulty: CaseIterable, Identifiable {
    case veryEasy
    case easy
    case medium
    case hard
    case veryHard
    case extreme
    
    var id: String { title }
    
    var title: String {
        switch self {
        case .veryEasy: return "Very Easy"
        case .easy:     return "Easy"
        case .medium:   return "Normal"
        case .hard:     return "Hard"
        case .veryHard: return "Very Hard"
        case .extreme:  return "Extreme"
        }
    }
    
    var numberOfPairs: Int {
        switch self {
        case .veryEasy: return 4
        case .easy:     return 6
        case .medium:   return 10
        case .hard:     return 12
        case .veryHard: return 14
        case .extreme:  return 20
        }
    }
}
