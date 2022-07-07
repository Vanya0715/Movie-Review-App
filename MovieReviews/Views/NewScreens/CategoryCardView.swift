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
        
        let diff = abs(x - 50)
        if diff > 100 {
            scale = 1 + (100 - diff) / 500
        }
        
        return scale
    }
    
    
    var body: some View {
        ZStack {
            GeometryReader { proxy in
                let scale = getScale(proxy: proxy)
                
                if self.imageLoader.image != nil {
                    VStack(alignment: .center, spacing: 20) {
                        Image(uiImage: self.imageLoader.image!)
                        
                            .resizable()
                            .scaledToFill()
                            .frame(width: 280, height: 480)
                            .clipped()
                            .cornerRadius(25)
                            .scaleEffect(CGSize(width: scale, height: scale))
                          
                    }
                   
                } else {
                    Rectangle()
                        .fill(Color.white)
                        .shadow(radius: 4)
                }
            }
            .frame(width: 290, height: 500).cornerRadius(25)
            .shadow(color: .black.opacity(0.5), radius: 8, x: 8, y: 8)
            .shadow(color: .white.opacity(0.5), radius: 4, x: -6, y: -8)
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
            
            VStack(alignment: .leading, spacing: 10) {

                Text(title).font(.system(size: 30, weight: .semibold))
                    .padding()
                
                ScrollView(.horizontal,showsIndicators: false) {
                    HStack(alignment:.center, spacing: 0) {
                        Spacer(minLength: 20)
                        ForEach(self.movies) { movie in
                        
                        NavigationLink(destination: MovieDetailView(movieId: movie.id)) {
                            CategoryCard(movie: movie)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
                Divider()
            }
           
        }
                     

    }
}

struct CategoryCardView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryCardView(title: "Now Playing", movies: Movie.stubbedMovies)
    }
}
