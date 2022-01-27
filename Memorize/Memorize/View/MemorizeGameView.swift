//
//  MemorizeGameView.swift
//  Memorize
//
//  Created by Donald Timpson on 1/26/22.
//

import SwiftUI

struct MemorizeGameView: View {
    @ObservedObject var viewModel: EmojiMemorizeGame
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card).aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                }
            }
            Spacer()
            newGame
        }
        .foregroundColor(viewModel.color)
        .padding(.horizontal)
        .navigationTitle(Text(viewModel.title))
    }
    
    private var newGame: some View {
        Button {
            viewModel.newGame()
        } label: {
            Text("New Game")
                .font(.largeTitle)
                .foregroundColor(.accentColor)
        }
    }
}

struct CardView: View {
    let card: EmojiMemorizeGame.Card
    
    var body: some View {
        ZStack {
            let cardShape = RoundedRectangle(cornerRadius: 15.0)
            if card.isFaceUp || card.isMatched {
                cardShape.fill().foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                cardShape.strokeBorder(lineWidth: 3.0)
                Text(card.content).font(.largeTitle)
            } else {
                cardShape.fill()
            }
        }.opacity(card.isMatched ? 0.8 : 1.0)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MemorizeGameView(viewModel: EmojiMemorizeGame(theme: .halloween, difficulty: .veryHard))
            .preferredColorScheme(.light)
    }
}
