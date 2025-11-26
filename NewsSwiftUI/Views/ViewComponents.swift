//
//  AsyncArticleImage.swift
//  NewsSwiftUI
//
//  Created by Bassma on 26.11.25.
//

import SwiftUI

struct PageTitle: View {
    var imageName: String
    var title: String
    var body: some View {
        HStack{
            Image(systemName: imageName)
                .foregroundStyle(.blue)
                .font(.title2)
            Text(title)
                .foregroundStyle(.blue)
                .font(.title2)
            Spacer()
        }
        .padding()
    }
}

struct ArticleRow: View {
    var favourite: Favourite
    var body: some View {
        VStack{
            AsyncImage(url: URL(string: favourite.urlToImage ?? "")) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .clipped()
                
            } placeholder: {
                ProgressView()
            }
            
            VStack(alignment: .leading, spacing: 7){
                Text(favourite.title)
                    .font(.title3)
                Text(favourite.content?.removingHTMLTags.preview(150) ?? "This content is not available")
                    .font(.callout)
                HStack{
                    Text(favourite.author ?? "")
                    Spacer()
                    Text(favourite.formattedDate)
                }
                .foregroundStyle(.gray)
                .font(.callout)
                
            }
            .padding(10)
            
        }
    }
}

struct AsyncArticleImage: View {
    var url : String
    var body: some View {
        AsyncImage(url: URL(string: url)) { image in
            image
                .resizable()
                .scaledToFit()
                .clipped()
            
        } placeholder: {
            ProgressView()
        }
    }
}

struct DetailsViewHStack: View {
    var imageName: String
    var author: String
    var body: some View {
        HStack(spacing: 5){
            Image(systemName: imageName)
            Text(author)
        }
        .font(.callout)
        .foregroundStyle(.black.opacity(0.7))
        .padding(.top, 5)
    }
}

struct SeperatorView: View {
    var body: some View {
        Rectangle()
            .frame(height: 0.3)
            .foregroundStyle(.black.opacity(0.7))
            .padding([.top, .bottom])
    }
}

struct FavButtonLbl: View {
    var body: some View {
        ZStack{
            Circle()
                .fill(.white)
                .frame(width: 40)
            Image(systemName: "star.fill")
                .font(.title2)
                .foregroundStyle(.blue)
                .scaleEffect(1.2)
            
        }
    }
}


