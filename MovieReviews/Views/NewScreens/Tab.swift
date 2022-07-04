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
    var tab: Title
    var color: Color
}

var tabItems = [
    TabItem(text: "Now Playing", icon: "bolt.circle", tab: .nowPlaying, color: .cyan),
    TabItem(text: "Upcoming", icon: "bell.circle", tab: .upcoming, color: .red),
    TabItem(text: "Top Rated", icon: "flame.circle", tab: .topRated, color: .green),
    TabItem(text: "Popular", icon: "heart.circle", tab: .popular, color: .purple)
]
