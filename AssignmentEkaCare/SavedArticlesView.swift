//
//  SavedArticlesView.swift
//  AssignmentEkaCare
//
//  Created by Mir Ohid Ali on 18/03/25.
//


import SwiftUI

struct SavedArticlesView: View {
    @StateObject var viewModel = NewsViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.savedArticles) { article in
                    VStack(alignment: .leading) {
                        Text(article.title).font(.headline)
                        Text(article.descriptionText ?? "").font(.subheadline).foregroundColor(.gray)
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            viewModel.deleteArticle(article)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
            }
            .navigationTitle("Saved Articles")
        }
    }
}
