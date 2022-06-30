//
//  Tab.swift
//  MovieReviews
//
//  Created by Divyansh Dwivedi on 10/05/22.
//

import SwiftUI

struct TabItem: Identifiable {
    var id = UUID()
    var text: String
    var icon: String
    var tab: Tab
    var color: Color
}

var tabItems = [
    TabItem(text: "Home", icon: "house", tab: .home, color: .teal),
    TabItem(text: "Movies", icon: "tv", tab: .movie, color: .blue),
    TabItem(text: "Search", icon: "magnifyingglass", tab: .search, color: .teal)
]

enum Tab: String {
    case home
    case movie
    case search
}
