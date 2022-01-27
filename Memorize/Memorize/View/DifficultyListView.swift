//
//  DifficultyListView.swift
//  Memorize
//
//  Created by Donald Timpson on 1/26/22.
//

import SwiftUI

struct DifficultyListView: View {
    let difficulties = Difficulty.allCases
    
    var body: some View {
        NavigationView {
            List {
                ForEach(difficulties) { difficulty in
                    NavigationLink(destination: ThemeListView(difficulty: difficulty)) {
                        DifficultyListViewCell(title: difficulty.title)
                    }
                }
            }
            .navigationTitle(Text("Difficulty"))
        }
        .listStyle(GroupedListStyle())
    }
}

struct DifficultyListViewCell: View {
    var title: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.title)
            Spacer()
        }
    }
}

struct DifficultyListView_Previews: PreviewProvider {
    static var previews: some View {
        DifficultyListView()
    }
}
