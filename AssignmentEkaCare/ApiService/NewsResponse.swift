//
//  NewsResponse.swift
//  AssignmentEkaCare
//
//  Created by Mir Ohid Ali on 18/03/25.
//


import Alamofire
import Foundation

struct NewsResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [NewsItem]
}

struct NewsItem: Codable, Identifiable {
    var id: String { url }
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
    
    struct Source: Codable {
        let id: String?
        let name: String
    }
}
class NewsAPIService {
    private let apiKey = "01699755f39f4672b52758f0d925882e"
    private let baseUrl = "https://newsapi.org/v2/everything"
    
    func fetchNews(query: String, completion: @escaping ([NewsItem]) -> Void) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDate = dateFormatter.string(from: Date())
        
        let parameters: [String: String] = [
            "q": query,
            "from": "2025-03-17",
            "to": "2025-03-17",
            "sortBy": "popularity",
            "apiKey": apiKey
        ]
        
        print("Making API request with parameters: \(parameters)")
        
        AF.request(baseUrl, parameters: parameters)
            .validate()
            .responseDecodable(of: NewsResponse.self) { response in
                switch response.result {
                case .success(let newsResponse):
                    print("Successfully fetched \(newsResponse.articles.count) articles")
                    DispatchQueue.main.async {
                        completion(newsResponse.articles)
                    }
                case .failure(let error):
                    print("Error fetching news: \(error)")
                    print("Response: \(String(describing: response.data?.prettyPrintedJSONString))")
                    DispatchQueue.main.async {
                        completion([])
                    }
                }
            }
    }
}

// Add extension for pretty printing JSON
extension Data {
    var prettyPrintedJSONString: String? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyString = String(data: data, encoding: .utf8) else { return nil }
        return prettyString
    }
}
