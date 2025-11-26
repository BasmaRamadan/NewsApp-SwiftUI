//
//  MainViewModel.swift
//  NewsSwiftUI
//
//  Created by Bassma on 26.11.25.
//

import Foundation
import SwiftData

enum DisplayMode {
    case news
    case favourites
}

@Observable
final class MainViewModel {
    
    private let service = NewsService()
    var articles = [Article]()
        
    func loadArticles() {
        Task {
            if NetworkMonitor.shared.isConnected {
                await fetchOnline()
            } else {
                self.articles = []
            }
        }
    }
    
    
    private func fetchOnline() async {
        do {
            let items = try await service.fetchArticles()
            self.articles = items
        } catch {
            print("Failed to fetch articles: \(error)")
            self.articles = []
        }
    }
    
}
extension String {
    var removingHTMLTags: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
            .replacingOccurrences(of: "\n", with: "")
            .replacingOccurrences(of: "\r", with: "")
        
    }
    func preview(_ length: Int) -> String {
        if self.count > length {
            let endIndex = self.index(self.startIndex, offsetBy: length)
            return String(self[..<endIndex]) + "..."
        } else {
            return self
        }
    }
}
