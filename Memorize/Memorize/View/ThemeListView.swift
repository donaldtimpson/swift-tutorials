//
//  ThemeListView.swift
//  Memorize
//
//  Created by Donald Timpson on 1/26/22.
//

import SwiftUI

struct ThemeListView: View {
    let difficulty: Difficulty
    let themes = EmojiTheme.allCases
    
    var body: some View {
        List {
            ForEach(themes) { theme in
                NavigationLink(destination: MemorizeGameView(viewModel: EmojiMemorizeGame(theme: theme, difficulty: difficulty))) {
                    ThemeListViewCell(name: theme.title, color: theme.color, detail: theme.emojis, difficulty: difficulty.title)
                }
            }
        }
        .navigationTitle(Text("Themes"))
        .listStyle(GroupedListStyle())
    }
}

struct ThemeListViewCell: View {
    var name: String
    var color: Color
    var detail: String
    var difficulty: String
    
    var body: some View {
        VStack {
            HStack {
                Text(name)
                    .font(.title)
                    .foregroundColor(color)
                Text("(\(difficulty))")
                    .font(.body)
                    .foregroundColor(color)
                Spacer()
            }
            HStack {
                Text(detail)
                    .font(.body)
                    .lineLimit(1)
                Spacer()
            }
        }
    }
}

struct ThemeListView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeListView(difficulty: .veryHard)
    }
}
