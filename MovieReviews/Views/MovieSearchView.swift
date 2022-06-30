//
//  MovieSearchView.swift
//  MovieReviews
//
//  Created by vanya sharma on 10/05/22.
//
import SwiftUI

struct MovieSearchView: View {
    
    @ObservedObject var movieSearchState = MovieSearchState()
    
    var body: some View {
        NavigationView {
            ZStack{
                Color.teal.opacity(0.2).edgesIgnoringSafeArea(.all)
                List {
                    SearchBarView(placeholder: "Search movies", text: self.$movieSearchState.query)
                        .listRowInsets(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                       
                    
                    LoadingView(isLoading: self.movieSearchState.isLoading, error: self.movieSearchState.error) {
                        self.movieSearchState.search(query: self.movieSearchState.query)
                    }
                    
                    if self.movieSearchState.movies != nil {
                        ForEach(self.movieSearchState.movies!) { movie in
                            NavigationLink(destination: MovieDetailView(movieId: movie.id)) {
                                VStack(alignment: .leading) {
                                    Text(movie.title)
                                    Text(movie.yearText)
                                }
                            }
                        }
                    }
                    
                }.listRowBackground(  Color.teal.opacity(0.2).edgesIgnoringSafeArea(.all))
                .onAppear {
                    self.movieSearchState.startObserve()
                }
            }

            .navigationBarTitle("Search").foregroundColor(.teal)
        }
    }
}

struct MovieSearchView_Previews: PreviewProvider {
    static var previews: some View {
        MovieSearchView()
    }
}
