//
//  NewsViewModel.swift
//  AssignmentEkaCare
//
//  Created by Mir Ohid Ali on 18/03/25.
//


import Foundation
import RealmSwift

class NewsViewModel: ObservableObject {
    @Published var articles: [NewsItem] = []
    @Published var savedArticles: [NewsArticle] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var showAlert = false
    @Published var alertTitle = ""
    @Published var alertMessage = ""
    
    private let apiService = NewsAPIService()
    private let realm = try! Realm()
    
    init() {
        print("NewsViewModel initialized")
        fetchNews(query: "apple")
        fetchSavedArticles()
    }
    
    func fetchNews(query: String) {
        isLoading = true
        errorMessage = nil
        print("Fetching news for query: \(query)")
        
        apiService.fetchNews(query: query) { [weak self] fetchedArticles in
            DispatchQueue.main.async {
                self?.isLoading = false
                self?.articles = fetchedArticles
                print("Fetched \(fetchedArticles.count) articles")
                
                if fetchedArticles.isEmpty {
                    self?.showAlert("No Results", "No articles found for your search.")
                } else {
                    // Print first article for debugging
                    if let firstArticle = fetchedArticles.first {
                        print("First article title: \(firstArticle.title)")
                    }
                }
            }
        }
    }
    
    func saveArticle(_ article: NewsItem) {
        let newsArticle = NewsArticle(
            id: article.id,
            source: article.source.name,
            author: article.author,
            title: article.title,
            description: article.description,
            url: article.url,
            urlToImage: article.urlToImage,
            publishedAt: article.publishedAt,
            content: article.content
        )
        
        do {
            try realm.write {
                realm.add(newsArticle, update: .modified)
            }
            showAlert("Success", "Article saved successfully!")
            fetchSavedArticles()
        } catch {
            showAlert("Error", "Failed to save article.")
        }
    }
    
    func showAlert(_ title: String, _ message: String) {
        alertTitle = title
        alertMessage = message
        showAlert = true
    }

    
    func fetchSavedArticles() {
        savedArticles = Array(realm.objects(NewsArticle.self))
    }
    
    func deleteArticle(_ article: NewsArticle) {
        try? realm.write {
            realm.delete(article)
        }
        fetchSavedArticles()
    }
}
