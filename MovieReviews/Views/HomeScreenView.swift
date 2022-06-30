//
//  HomeScreenView.swift
//  MovieReviews
//
//  Created by Divyansh Dwivedi on 10/05/22.
//

import SwiftUI

struct ImageModel: Identifiable {
    let id: Int
    let imageView: String
    let title: Title
}

enum Title: String {
    case upcoming = "Upcoming"
    case popular = "Popular"
    case nowPlaying = "Now Playing"
    case topRated = "Top Rated"
}


struct ImageView: View {
    
    @State var animate: Bool = false
    
    let postImages: ImageModel
    var body: some View {
        
        ZStack {

                VStack(alignment: .center){
                
                Spacer()
                   
                    NavigationLink(destination: MovieDetailView(movieId: postImages.id), label: {
                    Image(postImages.imageView)
                    .resizable()
                    .frame(width: 190, height: 400)
                    .clipShape(RoundedRectangle(cornerRadius: 120))
                    .shadow(
                        color: animate ? Color.teal.opacity(0.1) : Color.teal,
                        radius: animate ? 30 : 10,
                        x: 0,
                        y: animate ? -50 : -30)
                  
                    .scaleEffect(animate ? 1.1 : 1.0)
                    .offset(y: animate ? -7 : 0)
                
                    })
                
                Spacer()
                
                NavigationLink( destination: CategoryView(Categorytitle: postImages.title),
                                label: {
                    
                    Text(postImages.title.rawValue)
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(width: 170, height:45)
                        .background(Color.black)
                        .cornerRadius(120)
                        .shadow(
                            color: animate ? Color.teal : Color.teal.opacity(0.5),
                            radius: animate ? 30:10,
                            x: 0,
                            y: animate ? -20: -30)
                })
            }.onAppear(perform: addAnimation)
        
        }
        .frame(width: 250, height: 500)
        .clipShape(RoundedRectangle(cornerRadius: 120))
    
    }
    func addAnimation() {
        guard !animate else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation(Animation
                            .easeInOut(duration: 2.0)
                            .repeatForever()
            ) {
                animate.toggle()
            }
        }
    }
}


struct HomeScreenView: View {
    
    
    
    let images: [ImageModel] = [
        .init(id: 0, imageView: "1", title: .upcoming),
        .init(id: 1, imageView: "2", title: .popular),
        .init(id: 2, imageView: "3", title: .nowPlaying),
        .init(id: 3, imageView: "4", title: .topRated),
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.white
                
                Spacer()
                
                VStack(alignment:.center, spacing: 40) {
                    Text(" Select A Category")
                        .fontWeight(.bold)
                        .padding()
                        .multilineTextAlignment(.center)
                        .lineLimit(1)
                        .font(.system(size: 40))
                    
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .center, spacing: 50) {
                            Spacer()
                            ForEach(images, id: \.id) { post in
                                ImageView(postImages: post)
                            }
                            Spacer()
                        }
                    }.padding(.horizontal)
                    Spacer(minLength: 120)
                    
                }
            }
            
        }.navigationTitle(" Select A Category")
        
        
    }
    
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}
