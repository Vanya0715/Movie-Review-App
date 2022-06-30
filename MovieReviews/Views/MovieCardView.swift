//
//  MovieCardView.swift
//  MovieReviews
//
//  Created by Divyansh Dwivedi on 09/05/22.
//

import SwiftUI

struct MovieBackdropCard: View {
    
    let movie: Movie
    @ObservedObject var imageLoader = ImageLoader()
    
    var body: some View {
        ZStack {
            Color.teal.opacity(0)
            GeometryReader { proxy in
                let minX = proxy.frame(in: .global).minX

                        if self.imageLoader.image != nil {
                            Image(uiImage: self.imageLoader.image!)
                                .resizable()
                                .rotation3DEffect(.degrees(minX / -8), axis: (x: 0, y: 1, z: 0 ))
                        } else {
                            Rectangle()
                                .fill(Color.teal.opacity(0))
                        }
                    

            }
            .aspectRatio(16/9, contentMode: .fit)
            .cornerRadius(5)
            .shadow(radius: 4)
            .onAppear {
                self.imageLoader.loadImage(with: self.movie.backdropURL)
            }
        }
    }
}

struct MovieBackdropCard_Previews: PreviewProvider {
    static var previews: some View {
        MovieBackdropCard(movie: Movie.stubbedMovie).environmentObject(ImageLoader())
    }
}
