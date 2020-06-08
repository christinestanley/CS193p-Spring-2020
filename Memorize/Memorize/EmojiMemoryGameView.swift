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
                    withAnimation(.linear(duration: self.duration)) {
                        self.viewModel.choose(card: card)
                    }
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
    private let duration = 0.75
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    @State private var animatedBonusRemaining: Double = 0
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-animatedBonusRemaining*360-90), clockwise: true)
                            .onAppear {
                                self.startBonusTimeAnimation()
                        }
                    } else {
                        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-card.bonusRemaining*360-90), clockwise: true)
                    }
                }
                .padding(piePadding)
                .opacity(pieOpacity)
                .transition(.identity)
                
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(card.isMatched ? Animation.linear(duration: spinDuration).repeatForever(autoreverses: false) : .default)
            }
                //.modifier(Cardify(isFaceUp: card.isFaceUp))
                .cardify(isFaceUp: card.isFaceUp)
                .transition(AnyTransition.scale)
        }
    }
    
    // MARK: - Drawing Constants
    private let piePadding: CGFloat = 5
    private let pieOpacity = 0.35
    
    private let spinDuration = 1.0
    
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
                    withAnimation(.easeInOut) {
                        self.buttonAction()
                    }
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
