//
//  NewsArticle.swift
//  AssignmentEkaCare
//
//  Created by Mir Ohid Ali on 18/03/25.
//


import RealmSwift

class NewsArticle: Object, Identifiable {
    @Persisted(primaryKey: true) var id: String
    @Persisted var source: String
    @Persisted var author: String?
    @Persisted var title: String
    @Persisted var descriptionText: String?
    @Persisted var url: String
    @Persisted var urlToImage: String?
    @Persisted var publishedAt: String
    @Persisted var content: String?
    
    convenience init(id: String, source: String, author: String?, title: String, description: String?, url: String, urlToImage: String?, publishedAt: String, content: String?) {
        self.init()
        self.id = id
        self.source = source
        self.author = author
        self.title = title
        self.descriptionText = description
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.content = content
    }
}
