//
//  MovieDetailView.swift
//  MovieReviews
//
//  Created by Divyansh Dwivedi on 10/05/22.
//

import SwiftUI


struct MovieDetailView: View {
    
    let movieId: Int
    @ObservedObject private var movieDetailState = MovieDetailsState()
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            LoadingView(isLoading: self.movieDetailState.isLoading, error: self.movieDetailState.error) {
                self.movieDetailState.loadMovie(id: self.movieId)
            }
            
            if movieDetailState.movie != nil {
                MovieDetailListView(movie: self.movieDetailState.movie!)
            }
        }
        
    
        .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                self.movieDetailState.loadMovie(id: self.movieId)
            }

    }
}

struct MovieDetailListView: View {
    
    let movie: Movie
    
    let imageLoader = ImageLoader()
    let maxHeight = UIScreen.main.bounds.height / 2
    @State var offset: CGFloat = 0
    
    var body: some View {
      
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue.opacity(0.2), .purple.opacity(0.2)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
       
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    MovieDetail(movie: movie)
                        .ignoresSafeArea(.all, edges: .top)
                    Spacer()
                    Divider()
                    Spacer()
                Text(movie.overview) .padding()

                Divider()
                HStack(alignment: .top, spacing: 4) {
                    if movie.cast != nil && movie.cast!.count > 0 {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Starring")
                                .font(.system(size: 20, weight:.semibold, design:.serif))
                            
                            ForEach(self.movie.cast!.prefix(9)) { cast in
                                Text(cast.name)
                            }
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        Spacer()
                        
                    }
                    
                    if movie.crew != nil && movie.crew!.count > 0 {
                        VStack(alignment: .leading, spacing: 4) {
                            if movie.directors != nil && movie.directors!.count > 0 {
                                Text("Director(s)")
                                    .font(.system(size: 20, weight:.semibold, design:.serif))
                                
                                ForEach(self.movie.directors!.prefix(2)) { crew in
                                    Text(crew.name)
                                }
                            }
                            
                            if movie.producers != nil && movie.producers!.count > 0 {
                                Text("Producer(s)")
                                    .font(.system(size: 20, weight:.semibold, design:.serif))
                                
                                ForEach(self.movie.producers!.prefix(2)) { crew in
                                    Text(crew.name)
                                }
                            }
                            
                            if movie.screenWriters != nil && movie.screenWriters!.count > 0 {
                                Text("Screenwriter(s)")
                                    .font(.system(size: 22, weight:.semibold, design:.serif))
                                    .padding(.top)
                                ForEach(self.movie.screenWriters!.prefix(2)) { crew in
                                    Text(crew.name)
                                }
                            }
                        }
                    }
                }.padding()
                
            }.ignoresSafeArea(.all, edges: .top)
            
                    .navigationBarHidden(true)
            } .coordinateSpace(name: "SCROLL")
    }
    }
}

struct MovieDetail: View {
    
    let maxHeight = UIScreen.main.bounds.height / 1.6
    let movie: Movie
    @ObservedObject var imageLoader = ImageLoader()
    @State var offset: CGFloat = 0
    @Environment(\.presentationMode) private var presentationMode

    var body: some View {

            VStack {
                GeometryReader { proxy in
                    
                    VStack (spacing: 15) {
                        
                        if self.imageLoader.image != nil {
                            Image(uiImage: self.imageLoader.image!)
                                .resizable()
                                .edgesIgnoringSafeArea(.top)
                        }
                    }
                    .onAppear {
                        self.imageLoader.loadImage(with:  self.movie.posterURL)
                    }
                    .clipShape(CustomCorner(corners: [.bottomLeft,.bottomRight], radius: 60))
                    .frame(maxWidth: .infinity)
                    .frame(height: maxHeight + offset, alignment: .bottom)
                    .shadow(color: .black.opacity(0.7), radius: 8, y: 15)
                    

                }
                .frame(height: maxHeight)
                .offset(y: -offset)
                .padding(.bottom)
                
                VStack(alignment: .leading, spacing: 10) {
                
                        Text(movie.title)
                            .font(.system(size: 25, weight: .bold, design: .serif))
                            .padding(.horizontal)
                        HStack {
                            Text(movie.genreText)
                            Text("|")
                            Text(movie.yearText)
                            Text("|")
                            Text(movie.durationText)
                        }
                        .padding(.horizontal)
                        .font(.system(size: 18, weight: .medium, design: .serif))
                        HStack {
                        Text(movie.scoreText)
                            Text(movie.ratingText).foregroundColor(.yellow)
                        }
                        .padding(.horizontal)
                        .font(.system(size: 18, weight: .medium, design: .serif))
                 
                    }
              
                .frame(width: 375, alignment: .leading)
                .padding(.top, 15)
            }
            .modifier(OffsetModifier(offset: $offset))
    }
}
    struct MovieDetailView_Previews: PreviewProvider {
        static var previews: some View {
            NavigationView {
                MovieDetailView(movieId: Movie.stubbedMovie.id)
            }
        }
        
    }

