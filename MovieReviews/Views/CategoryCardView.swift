//
//  CategoryCardView.swift
//  MovieReviews
//
//  Created by Divyansh Dwivedi on 12/05/22.
//

import SwiftUI

struct CategoryCard: View {
    
    let movie: Movie
    @ObservedObject var imageLoader = ImageLoader()
  
    
    var body: some View {
        ZStack {
            GeometryReader { proxy in
                let minX = proxy.frame(in: .global).minX
                
                if self.imageLoader.image != nil {
                    
                    Image(uiImage: self.imageLoader.image!)
                    
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 120))
                        .rotation3DEffect(.degrees(minX / -8), axis: (x: 0, y: 1, z: 0 ))

                } else {
                    Rectangle()
                        .fill(Color.white)
                        .shadow(radius: 4)
                }
            }
            .frame(width: 250, height: 450).cornerRadius(120)
            .onAppear {
                self.imageLoader.loadImage(with: self.movie.posterURL)
            }
        }
    }
}

struct CategoryCardView: View {
    
    let title: String
    let movies: [Movie]
    
    var body: some View {
        ZStack{
            
            VStack(alignment: .leading, spacing: 70) {
               Spacer()
                Text(title)
                    .foregroundColor(.teal)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                    .font(.system(size: 50))
                    .transition(.move(edge: .bottom))
              
                
                ScrollView(.horizontal,showsIndicators: false) {
                    HStack(alignment:.center, spacing: 16) {
                        
                        ForEach(self.movies) { movie in
                            
                        NavigationLink(destination: MovieDetailView(movieId: movie.id)) {
                            CategoryCard(movie: movie)
                            
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.leading, movie.id == self.movies.first!.id ? 16 : 0)
                        .padding(.trailing, movie.id == self.movies.last!.id ? 16 : 0)
                        
                        
                    }
                }
            }
            Spacer(minLength: 150)
            
        }
        }.transition( .move(edge: .leading))
                     

    }
}

struct CategoryCardView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryCardView(title: "Now Playing", movies: Movie.stubbedMovies)
    }
}
