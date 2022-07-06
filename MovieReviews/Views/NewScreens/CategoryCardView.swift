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
    private func getScale(proxy: GeometryProxy) -> CGFloat {
        var scale: CGFloat = 1
        
        let x = proxy.frame(in: .global).minX
        
        let diff = abs(x - 30)
        if diff < 100 {
            scale = 1 + (100 - diff) / 500
        }
        
        return scale
    }
    
    
    var body: some View {
        ZStack {
            GeometryReader { proxy in
                let scale = getScale(proxy: proxy)
                
                if self.imageLoader.image != nil {
                    VStack {
                        Image(uiImage: self.imageLoader.image!)
                        
                            .resizable()
                            .scaledToFill()
                            .frame(width: 200, height: 300)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 0.5)
                            )
                            .clipped()
                            .cornerRadius(5)
                            .shadow(radius: 5)
                            
                            .scaleEffect(CGSize(width: scale, height: scale))
                            
                        VStack(alignment: .leading, spacing: 6) {
                        Text(movie.title)
                                .font(.system(size: 20, weight: .semibold, design: .serif))
                        Text("Rating: \(movie.scoreText)")
                        Text("Year: \(movie.yearText)")
                        }
                        .frame(width: 200, height: 80, alignment: .leading)
                        .padding(.vertical, 28)
                    }
                    .frame(width: 200, height: 400)
                   
                } else {
                    Rectangle()
                        .fill(Color.white)
                        .shadow(radius: 4)
                }
            }
            .frame(width: 150, height: 400)
            .onAppear {
                self.imageLoader.loadImage(with: self.movie.posterURL)
            }
        }.padding(32)
    }
}

struct CategoryCardView: View {
    
    let title: String
    let movies: [Movie]
    

    var body: some View {
        ZStack{
            
            VStack(alignment: .leading, spacing: 20) {

                Text(title).font(.system(size: 30, weight: .semibold))
                    .padding(.horizontal)
              
                
                ScrollView(.horizontal,showsIndicators: false) {
                    HStack(alignment:.center, spacing: 12) {
                        Spacer()
                        ForEach(self.movies) { movie in
                        
                        NavigationLink(destination: MovieDetailView(movieId: movie.id)) {
                            CategoryCard(movie: movie)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding()
                        
                        
                    }
                }
            }
        }
        }
                     

    }
}

struct CategoryCardView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryCardView(title: "Now Playing", movies: Movie.stubbedMovies)
    }
}
