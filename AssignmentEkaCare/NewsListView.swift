//
//  NewsListView.swift
//  AssignmentEkaCare
//
//  Created by Mir Ohid Ali on 18/03/25.
//


import SwiftUI

struct NewsListView: View {
    @StateObject var viewModel = NewsViewModel()
    
    var body: some View {
        NavigationStack {
            List(viewModel.articles) { article in
                NavigationLink(destination: WebViewContainer(url: article.url, viewModel: viewModel, article: article)) {
                    VStack(alignment: .leading) {
                        Text(article.title).font(.headline)
                        Text(article.description ?? "").font(.subheadline).foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("Latest News")
        }
    }
}
