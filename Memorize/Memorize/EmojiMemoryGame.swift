//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Chris on 23/05/2020.
//  Copyright © 2020 Christine Stanley. All rights reserved.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
        
    static func createMemoryGame() -> MemoryGame<String> {
        // MARK: - Extra Credit
        let emojis = ["👻", "🎃", "🕷", "🕸", "🦇", "🍭", "😱", "👽", "🧟", "🦹", "🧙‍♀️", "🧛‍♂️"].shuffled()
        return MemoryGame<String>(numberOfPairsOfCards: Int.random(in: 2...5)) { pairIndex in emojis[pairIndex] }
    }
    
    // MARK: - Access to the Model
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
}

struct EmojiMemoryGame_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
