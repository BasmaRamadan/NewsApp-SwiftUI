//
//  ContentView.swift
//  NewsSwiftUI
//
//  Created by Bassma on 26.11.25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var favourites : [Favourite]
    
    @State private var displayMode: DisplayMode = .news
    
    @State private var viewModel = MainViewModel()
    @State private var isDetailsPresented = false
    @State private var selectedArticle: Article? = nil
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading){
                if displayMode == .news {
                    NewsView()
                } else {
                    FavouriteView()
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Button {
                            withAnimation(.spring()) {
                                displayMode = (displayMode == .news ? .favourites : .news)
                            }
                        } label: {
                            Text(displayMode == .news ? "Show Favourites" : "Show News")
                            Image(systemName: displayMode == .news ? "star.fill" : "newspaper.fill")
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                            .font(.title3)
                    }
                }
            }
        }
    }  
}


#Preview {
    ContentView()
}
