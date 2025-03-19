//
//  NewsViewModel.swift
//  AssignmentEkaCare
//
//  Created by Mir Ohid Ali on 18/03/25.

import Foundation
import RealmSwift

class NewsViewModel: ObservableObject {
    @Published var articles: [NewsItem] = []
    @Published var savedArticles: [NewsArticle] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var isShowingAlert = false
    @Published var alertTitle = ""
    @Published var alertMessage = ""

    private let apiService = NewsAPIService()
    private var realm: Realm

    init() {
        do {
            realm = try Realm()
        } catch {
            fatalError("Failed to initialize Realm: \(error)")
        }
        
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
                    self?.showAlert(title: "No Results", message: "No articles found for your search.")
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
            DispatchQueue.main.async {
                self.fetchSavedArticles()  // Update UI in real-time
                self.showAlert(title: "Success", message: "Article saved successfully!")
            }
        } catch {
            showAlert(title: "Error", message: "Failed to save article.")
        }
    }

    func fetchSavedArticles() {
        let articles = realm.objects(NewsArticle.self)
        self.savedArticles = articles.map { article in
            NewsArticle(
                id: article.id,
                source: article.source,
                author: article.author,
                title: article.title,
                description: article.descriptionText,
                url: article.url,
                urlToImage: article.urlToImage,
                publishedAt: article.publishedAt,
                content: article.content
            )
        }
    }

    
    
    func deleteArticle(_ article: NewsArticle) {
        do {
            try realm.write {
                if let objectToDelete = realm.object(ofType: NewsArticle.self, forPrimaryKey: article.id) {
                    realm.delete(objectToDelete)
                }
            }

            // Refresh list safely
            DispatchQueue.main.async {
                self.fetchSavedArticles()
            }
        } catch {
            DispatchQueue.main.async {
                self.showAlert(title: "Error", message: "Failed to delete article.")
            }
        }
    }


    func showAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        isShowingAlert = true
    }
}

