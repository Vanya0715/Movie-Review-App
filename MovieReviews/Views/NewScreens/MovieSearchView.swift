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
       
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue.opacity(0.2), .purple.opacity(0.2)]), startPoint: .top, endPoint: .bottom)
                           .edgesIgnoringSafeArea(.all)
               ScrollView {
                   VStack {
                    SearchBarView(placeholder: "Search movies", text: self.$movieSearchState.query)
                    
                    LoadingView(isLoading: self.movieSearchState.isLoading, error: self.movieSearchState.error) {
                        self.movieSearchState.search(query: self.movieSearchState.query)
                    }
                    
                    if self.movieSearchState.movies != nil {
                        ForEach(self.movieSearchState.movies!) { movie in
                            NavigationLink(destination: MovieDetailView(movieId: movie.id)) {
                                VStack(alignment: .leading) {
                                    Text(movie.title)
                                    Text(movie.yearText)
                                    Divider()
                                }.padding(.leading)
                            }
                        }
                    }
                 }
             }
        }
                .onAppear {
                    self.movieSearchState.startObserve()
                }
                .navigationBarTitleDisplayMode(.inline).foregroundColor(.black)

            .navigationBarHidden(false)
        
    }
}

struct MovieSearchView_Previews: PreviewProvider {
    static var previews: some View {
        MovieSearchView()
    }
}
