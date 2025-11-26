//
//  FavouriteView.swift
//  NewsSwiftUI
//
//  Created by Bassma on 26.11.25.
//

import SwiftUI
import SwiftData

struct FavouriteView: View {
    @Environment(\.modelContext) var modelContext
    @Query var favourites : [Favourite]
    
    @State private var isDetailsPresented = false
    @State private var selectedArticle: Article? = nil
    var body: some View {
        VStack{
            PageTitle(imageName: "star.fill", title: "Favourite")
            if favourites.isEmpty{
                Text("No favourite articles found")
                    .font(.title3)
                    .foregroundStyle(.black.opacity(0.8))
            }else{
                List{
                    ForEach(favourites){ favourite in
                        ZStack(alignment: .topTrailing){
                            ArticleRow(favourite: favourite)
                            Button{
                                withAnimation(.easeInOut) {
                                    removeFavorite(favourite)
                                }
                            }label: {
                                FavButtonLbl()
                            }
                            .buttonStyle(.plain)
                            .padding(10)
                        }
                        .onTapGesture {
                            selectedArticle = Article(title: favourite.title, description: "", author: favourite.author, url: favourite.url, urlToImage: favourite.urlToImage, publishedAt: favourite.formattedDate, content: favourite.content)
                        }
                    }
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(radius: 4)
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
                .sheet(item: $selectedArticle) { article in
                    DetailsView(article: article)
                }
            }
        }
    }
    private func removeFavorite(_ favourite: Favourite) {
        guard let url = favourite.url else { return }
        
        if let existing = favourites.first(where: { $0.url == url }) {
            withAnimation(.spring()) {
                modelContext.delete(existing)
            }
        }
    }
}

#Preview {
    FavouriteView()
}
