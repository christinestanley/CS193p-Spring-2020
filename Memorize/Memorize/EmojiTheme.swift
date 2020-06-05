//
//  EmojiTheme.swift
//  Memorize
//
//  Created by Chris on 03/06/2020.
//  Copyright © 2020 Christine Stanley. All rights reserved.
//

import SwiftUI

struct EmojiTheme {
    let name: String
    let emojis: [String]
    let color: Color
    
    init() {
        let themes: [(name:String, emojis:[String], number: Int?, color: Color)] = [
            ("Halloween", ["👻", "🎃", "🕷", "🕸", "🦇", "🍭", "😱", "👽", "🧟", "🦹", "🧙‍♀️", "🧛‍♂️"], nil, .orange ),
            ("Animals", ["🦊", "🐯", "🐸", "🐷", "🐻"], 3, .green),
            ("Sports", ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉"], nil, .red),
            ("Weather", ["☀️", "❄️", "💨", "🌈", "☔️", "🌩"], 5, .purple),
            ("Space", ["🪐", "✨", "☄️", "🚀", "👩‍🚀"], 4, .yellow),
            ("Flags", ["🇿🇦", "🏴󠁧󠁢󠁷󠁬󠁳󠁿", "🇸🇪", "🇰🇷", "🇹🇷", "🇻🇪"], 6, .blue)
        ]
        
        let chosenTheme = themes.randomElement()!
        let number = chosenTheme.number ?? Int.random(in: 2...chosenTheme.emojis.count)

        self.name = chosenTheme.name
        self.color = chosenTheme.color
        self.emojis = Array(chosenTheme.emojis.shuffled().prefix(number))
    }
}
