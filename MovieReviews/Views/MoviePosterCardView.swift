//
//  MoviePosterCardView.swift
//  MovieReviews
//
//  Created by Divyansh Dwivedi on 09/05/22.
//

import SwiftUI

struct MoviePosterCardView: View {
     
    let movie: Movie
    @ObservedObject var imageLoader = ImageLoader()
    
    var body: some View {
        ZStack {
            Color.teal.opacity(0).ignoresSafeArea()
            GeometryReader { proxy in
                let minX = proxy.frame(in: .global).minX
                
                if self.imageLoader.image != nil {
                    
                    Image(uiImage: self.imageLoader.image!)
                    
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 120))
                        .shadow(color: .teal, radius: 5, x: 2.5, y: 2.5)
                        
                        .rotation3DEffect(.degrees(minX / -8), axis: (x: 0, y: 1, z: 0 ))
                       
                } else {
                    Rectangle()
                        .fill(Color.teal.opacity(0))
                        .shadow(radius: 4)
                }
            }
            .frame(width: 250, height: 340).cornerRadius(120)
            .onAppear {
                self.imageLoader.loadImage(with: self.movie.posterURL)
            }
        }
    }
}

struct MoviePosterCardView_Previews: PreviewProvider {
    static var previews: some View {
        MoviePosterCardView(movie: Movie.stubbedMovie)
    }
}
