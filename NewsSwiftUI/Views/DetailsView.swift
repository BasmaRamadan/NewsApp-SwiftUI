//
//  DetailsView.swift
//  NewsSwiftUI
//
//  Created by Bassma on 26.11.25.
//

import SwiftUI

struct DetailsView: View {
    var article: Article
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Spacer()
                Button("Dismiss"){
                    dismiss()
                }
                .padding(10)
            }
            AsyncArticleImage(url: article.urlToImage ?? "")
            
            VStack(alignment: .leading, spacing: 5){
                Text(article.title)
                    .font(.title3)
                
                DetailsViewHStack(imageName: "person", author: article.author ?? "")
                DetailsViewHStack(imageName: "calendar", author: article.formattedDate)

                SeperatorView()
                Text(article.content?.removingHTMLTags ?? "This content is not available")
                    .font(.callout)
                    .foregroundStyle(.black.opacity(0.7))
            }
            .padding()
            Spacer()
        }
    }
}

#Preview {
    DetailsView(article: Article(title: "Title", description: "", author: "Author", url: "", urlToImage: "https://media.wired.com/photos/69251bccf3fd885cd324b708/191:100/w_1280,c_limit/Apple's%20Entry-Level%20iPad%20Is%20on%20Sale.png", publishedAt: "26-11-2025", content: "Content"))
}
