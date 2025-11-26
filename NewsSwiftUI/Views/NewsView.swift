//
//  NewsView.swift
//  NewsSwiftUI
//
//  Created by Bassma on 26.11.25.
//

import SwiftUI
import SwiftData

struct NewsView: View {
    @Environment(\.modelContext) var modelContext
    @Query var favourites : [Favourite]
    
    private var networkMonitor = NetworkMonitor.shared
    @State private var viewModel = MainViewModel()
    @State private var isDetailsPresented = false
    @State private var selectedArticle: Article? = nil
    @State private var isNetworkDownAlertShown = false
    
    var body: some View {
        VStack(alignment: .leading){
            PageTitle(imageName: "newspaper", title: "Apple News")

            List{
                ForEach(viewModel.articles){ article in
                    ZStack(alignment: .topTrailing){
                        ArticleRow(favourite: Favourite(title: article.title,author: article.author ?? "",
                                                        url: article.url, urlToImage: article.urlToImage,
                                                        publishedAt: article.formattedDate, content: article.content))

                        Button{
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                toggleFavorite(article)
                            }
                        }label: {
                            ZStack{
                                Circle()
                                    .fill(.white)
                                    .frame(width: 40)
                                Image(systemName: isFavorite(article) ? "star.fill" : "star")
                                    .font(.title2)
                                    .foregroundStyle(.blue)
                                    .scaleEffect(isFavorite(article) ? 1.2 : 1.0)
                                
                            }
                        }
                        .buttonStyle(.plain)
                        .padding(10)
                    }
                    .onTapGesture {
                        selectedArticle = article
                    }
                }
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(radius: 4)
                .listRowSeparator(.hidden)
            }
            .task {
                loadArticles()
            }
            .alert("No Internet Connection", isPresented: $isNetworkDownAlertShown){
                Button("OK") { }
                Button("Try again"){
                    loadArticles()
                }
            } message: {
                Text("Please check your connection and try again.")
            }
            .listStyle(.plain)
            .sheet(item: $selectedArticle) { article in
                DetailsView(article: article)
            }
        }
    }
    private func loadArticles(){
        if networkMonitor.isConnected{
            viewModel.loadArticles()
        }else{
            isNetworkDownAlertShown = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                isNetworkDownAlertShown = true
            }
        }
    }
    private func isFavorite(_ article: Article) -> Bool {
        guard let url = article.url else { return false }
        return favourites.contains { $0.url == url }
    }
    
    private func toggleFavorite(_ article: Article) {
        guard let url = article.url else { return }
        
        if let existing = favourites.first(where: { $0.url == url }) {
            withAnimation(.spring()) {
                modelContext.delete(existing)
            }
        } else {
            withAnimation(.spring()) {
                let fav = Favourite(title: article.title, author: article.author ?? "", url: article.url, urlToImage: article.urlToImage, publishedAt: article.formattedDate, content: article.content)
                modelContext.insert(fav)
            }
        }
    }
}

#Preview {
    NewsView()
}
