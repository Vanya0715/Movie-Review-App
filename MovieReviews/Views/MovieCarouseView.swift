//
//  MovieCarouseView.swift
//  MovieReviews
//
//  Created by Divyansh Dwivedi on 09/05/22.
//

import SwiftUI

struct MovieCarouseView: View {
    let title: String
    let movies: [Movie]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            ScrollView(.horizontal,showsIndicators: false) {
                HStack(alignment:.top, spacing: 16) {
                    ForEach(self.movies) { movie in
                        NavigationLink(destination: MovieDetailView(movieId: movie.id)) {
                            MovieBackdropCard(movie: movie)
                                .frame(width: 272, height: 200)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.leading, movie.id == self.movies.first!.id ? 16 : 0)
                        .padding(.trailing, movie.id == self.movies.last!.id ? 16 : 0)
                        
                        
                    }
                }
            }
        }
    }
}

struct MovieCarouseView_Previews: PreviewProvider {
    static var previews: some View {
        MovieCarouseView(title: "Latest", movies: Movie.stubbedMovies)
    }
}
