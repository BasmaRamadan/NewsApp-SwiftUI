//
//  Favourite.swift
//  NewsSwiftUI
//
//  Created by Bassma on 26.11.25.
//

import Foundation
import SwiftData

@Model
class Favourite: Identifiable{
    var id: String { url ?? UUID().uuidString }

    var title: String
    var url: String?
    var urlToImage: String?
    var publishedAt: String
    var content: String?
    var author: String?
    var formattedDate: String {
        let isoFormatter = ISO8601DateFormatter()
        if let date = isoFormatter.date(from: publishedAt) {
            let f = DateFormatter()
            f.dateFormat = "MMM dd, yyyy"
            return f.string(from: date)
        }
        return publishedAt
    }
    
    init(title: String, author: String, url: String?, urlToImage: String?, publishedAt: String, content: String?) {
        self.title = title
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.content = content
        self.author = author
    }
}
