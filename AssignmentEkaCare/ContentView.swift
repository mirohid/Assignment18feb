//
//  ContentView.swift
//  AssignmentEkaCare
//
//  Created by Mir Ohid Ali on 18/03/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NewsListView()
                .tabItem {
                    Label("News", systemImage: "newspaper")
                }
            
            SavedArticlesView()
                .tabItem {
                    Label("Saved", systemImage: "bookmark")
                }
        }
    }
}

#Preview {
    ContentView()
}
