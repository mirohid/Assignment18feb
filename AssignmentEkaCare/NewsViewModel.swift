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
    
    private let apiService = NewsAPIService()
    private let realm = try! Realm()
    
    init() {
        fetchNews(query: "apple")
        fetchSavedArticles()
    }
    
    func fetchNews(query: String) {
        apiService.fetchNews(query: query) { [weak self] fetchedArticles in
            self?.articles = fetchedArticles
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
        
        try? realm.write {
            realm.add(newsArticle, update: .modified)
        }
        fetchSavedArticles()
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
