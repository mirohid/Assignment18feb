//
//  SavedArticlesView.swift
//  AssignmentEkaCare
//
//  Created by Mir Ohid Ali on 18/03/25.
//


import SwiftUI

struct SavedArticlesView: View {
    @StateObject var viewModel = NewsViewModel()
    
    private let columns = [
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if viewModel.savedArticles.isEmpty {
                    Text("No saved articles")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(viewModel.savedArticles) { article in
                            SavedArticleCard(article: article, viewModel: viewModel)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Saved Articles")
            .alert(viewModel.alertTitle, isPresented: $viewModel.showAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(viewModel.alertMessage)
            }
        }
    }
}

struct SavedArticleCard: View {
    let article: NewsArticle
    let viewModel: NewsViewModel
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            if let imageUrl = article.urlToImage {
                AsyncImage(url: URL(string: imageUrl)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                }
                .frame(width: 80, height: 80)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            
            VStack(alignment: .leading, spacing: 6) {
                Text(article.title)
                    .font(.headline)
                    .lineLimit(2)
                
                Text(article.descriptionText ?? "")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(2)
                
                HStack {
                    Text("Read More...")
                        .font(.caption)
                        .foregroundColor(.blue)
                    
                    Spacer()
                    
                    Button(action: {
                        viewModel.deleteArticle(article)
                        viewModel.showAlert("Success", "Article deleted successfully!")
                    }) {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                    }
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
                .shadow(radius: 2)
        )
    }
}

