//
//  Article.swift
//  NewsSwiftUI
//
//  Created by Bassma on 26.11.25.
//
import Foundation
import SwiftData

struct ArticleResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

struct Article: Identifiable, Codable, Equatable {
    var id: String { url ?? UUID().uuidString }

    let title: String
    let description: String?
    let author: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String
    let content: String?
    var formattedDate: String {
        let isoFormatter = ISO8601DateFormatter()
        if let date = isoFormatter.date(from: publishedAt) {
            let f = DateFormatter()
            f.dateFormat = "MMM dd, yyyy"
            return f.string(from: date)
        }
        return publishedAt
    }
}
