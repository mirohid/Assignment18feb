//
//  NewsListView.swift
//  AssignmentEkaCare
//
//  Created by Mir Ohid Ali on 18/03/25.
//


import SwiftUI

struct NewsListView: View {
    @StateObject var viewModel = NewsViewModel()
    
    private let columns = [
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if viewModel.isLoading {
                    ProgressView()
                        .padding()
                } else if viewModel.articles.isEmpty {
                    VStack {
                        Text("No articles found")
                            .foregroundColor(.gray)
                            .padding()
                        Button("Retry") {
                            viewModel.fetchNews(query: "apple")
                        }
                    }
                } else {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(viewModel.articles) { article in
                            NavigationLink(destination: WebViewContainer(url: article.url, viewModel: viewModel, article: article)) {
                                ArticleCard(article: article)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Latest News")
            .alert(viewModel.alertTitle, isPresented: $viewModel.isShowingAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(viewModel.alertMessage)
            }
            .onAppear {
                if viewModel.articles.isEmpty {
                    viewModel.fetchNews(query: "apple")
                }
            }
        }
    }
}

struct ArticleCard: View {
    let article: NewsItem
    
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
                
                Text(article.description ?? "")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(2)
                HStack{
                    Spacer()
                   Text("Read More...")
                        .font(.subheadline)
                        .foregroundStyle(.blue)
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

#Preview{
    NewsListView()
}
