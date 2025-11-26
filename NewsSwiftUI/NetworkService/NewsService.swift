//
//  NewsService.swift
//  NewsSwiftUI
//
//  Created by Bassma on 26.11.25.
//

import Foundation

final class NewsService {
    
    func fetchArticles() async throws -> [Article] {
        let urlString = "https://newsapi.org/v2/everything?q=apple&from=2025-11-24&to=2025-11-24&sortBy=popularity&apiKey=875f815e09fd413491065234702c8864"
        guard let url = URL(string: urlString) else { throw URLError(.badURL) }
        
        do {
            // Async fetch
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // Decode JSON
            let decoded = try JSONDecoder().decode(ArticleResponse.self, from: data)
            return decoded.articles
        } catch {
            throw error
        }
    }
}

