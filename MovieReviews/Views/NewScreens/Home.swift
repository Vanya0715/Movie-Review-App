//
//  Home.swift
//  MovieReviews
//
//  Created by Divyansh Dwivedi on 04/07/22.
//

import SwiftUI

struct Home: View {
    @ObservedObject var movieSearchState = MovieSearchState()
    var body: some View {
        ZStack{
            VStack {
                
                        NavigationLink {
                            MovieSearchView()
                        } label: {
                            SearchBarView(placeholder: "Search Here", text: self.$movieSearchState.query)
                        }
                TabView()
            }
        }
        .navigationBarHidden(true)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
