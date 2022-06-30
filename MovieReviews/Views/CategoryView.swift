//
//  CategoryView.swift
//  MovieReviews
//
//  Created by Divyansh Dwivedi on 11/05/22.
//

import SwiftUI

struct CategoryView: View {
    
    @ObservedObject private var nowPlayingState = MovieListState()
    @ObservedObject private var upcomingState = MovieListState()
    @ObservedObject private var topRatedState = MovieListState()
    @ObservedObject private var popularState = MovieListState()
    @State var Categorytitle: Title
    
    var body: some View {
        ZStack {
            switch Categorytitle {
            case .upcoming:
                Group {
                    if upcomingState.movies != nil {
                        CategoryCardView(title: "Upcoming", movies: upcomingState.movies!)
                    } else {
                        LoadingView(isLoading: self.upcomingState.isLoading, error: self.upcomingState.error) {
                            self.upcomingState.loadMovies(with: .upcoming)
                        }
                    }
                }
            case .popular:
                Group {
                    if popularState.movies != nil {
                        CategoryCardView(title: "Popular", movies: popularState.movies!)
                        
                    } else {
                        LoadingView(isLoading: self.popularState.isLoading, error: self.popularState.error) {
                            self.popularState.loadMovies(with: .popular)
                        }
                    }
                }
            case .nowPlaying:
                Group {
                    
                    if nowPlayingState.movies != nil {
                        CategoryCardView(title: "Now Playing", movies: nowPlayingState.movies!)
                        
                    } else {
                        LoadingView(isLoading: self.nowPlayingState.isLoading, error: self.nowPlayingState.error) {
                            self.nowPlayingState.loadMovies(with: .nowPlaying)
                        }
                    }
                }
            case .topRated:
                
                
                Group {
                    if topRatedState.movies != nil {
                        CategoryCardView(title: "Top Rated", movies: topRatedState.movies!)
                        
                    } else {
                        LoadingView(isLoading: self.topRatedState.isLoading, error: self.topRatedState.error) {
                            self.topRatedState.loadMovies(with: .topRated)
                        }
                    }
                    
                    
                }
            }
        }
        .onAppear {
            self.nowPlayingState.loadMovies(with: .nowPlaying)
            self.upcomingState.loadMovies(with: .upcoming)
            self.topRatedState.loadMovies(with: .topRated)
            self.popularState.loadMovies(with: .popular)
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(Categorytitle: .upcoming)
    }
}
