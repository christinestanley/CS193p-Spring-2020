//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Chris on 23/05/2020.
//  Copyright © 2020 Christine Stanley. All rights reserved.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String>
    @Published private var theme: EmojiTheme
    
    init() {
        let theme = EmojiTheme()
        self.theme = theme
        self.model = MemoryGame<String>(numberOfPairsOfCards: theme.emojis.count) { pairIndex in theme.emojis[pairIndex] }
    }
    
    // MARK: - Access to the Model
    var themeName: String { theme.name }
    var themeColor: Color { theme.color}
    var score: Int { model.score }
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    // MARK: - Intent(s)
    func startNewGame() {
        theme = EmojiTheme()
        model = MemoryGame<String>(numberOfPairsOfCards: theme.emojis.count) { pairIndex in theme.emojis[pairIndex] }
    }
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
}
