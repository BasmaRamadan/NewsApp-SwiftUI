//
//  NewsSwiftUIApp.swift
//  NewsSwiftUI
//
//  Created by Bassma on 26.11.25.
//

import SwiftUI
import SwiftData

@main
struct NewsSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.light)
        }
        .modelContainer(for: Favourite.self)
        
    }
}
