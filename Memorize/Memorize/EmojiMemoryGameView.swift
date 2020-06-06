//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Chris on 22/05/2020.
//  Copyright © 2020 Christine Stanley. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            Grid (viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    self.viewModel.choose(card: card)
                }
                .padding(self.cardPadding)
            }
            .padding()
            .foregroundColor(viewModel.themeColor)
            
            GameControls(score: viewModel.score, title: viewModel.themeName, color: viewModel.themeColor, buttonAction: viewModel.startNewGame)
           .padding([.leading, .trailing, .bottom])
        }
    }
    
    // MARK: - Drawing Constants
    
    private let cardPadding: CGFloat = 5
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    private func body(for size: CGSize) -> some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(lineWidth: edgeLineWidth)
                Pie(startAngle: Angle.degrees(-90), endAngle: Angle.degrees(20), clockwise: true)
                    .padding(piePadding)
                    .opacity(pieOpacity)
                Text(card.content)
            } else {
                if !card.isMatched {
                    RoundedRectangle(cornerRadius: cornerRadius)
                    .fill()
                }
            }
        }
        .font(Font.system(size: fontSize(for: size)))
    }
    
    // MARK: - Drawing Constants
    
    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 3
    private let piePadding: CGFloat = 5
    private let pieOpacity = 0.35
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.70
    }
}

struct GameControls: View {
    var score: Int
    var title: String
    var color: Color
    var buttonAction: () -> Void
    
    var body: some View {
        HStack {
            HStack(alignment: .firstTextBaseline) {
                Text("Score: \(score)")
                Spacer()
                Text(title)
                    .font(.title)
                    .foregroundColor(color)
                Spacer()
                Button("New Game") {
                    self.buttonAction()
                }
                
            }
            .font(.headline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[0])
        return EmojiMemoryGameView(viewModel: game)
    }
}
