//
//  TabView.swift
//  MovieReviews
//
//  Created by Divyansh Dwivedi on 10/05/22.
//

import SwiftUI

struct TabView: View {
    
    @State var selectedTab: Title = .nowPlaying
    @State var color: Color = .teal
    
    var body: some View {
      
        ZStack(alignment: .bottom) {
            VStack {
                
            Group{
                switch selectedTab {
                case.upcoming:
                    CategoryView(Categorytitle: .upcoming)
                case.topRated:
                    CategoryView(Categorytitle: .topRated)
                case.popular:
                    CategoryView(Categorytitle: .popular)
                case .nowPlaying:
                    CategoryView(Categorytitle: .nowPlaying)
                }
            }
                .padding()
           
            HStack {
                ForEach(tabItems) { items in
                    Button {
                       
                            selectedTab = items.tab
                            color = items.color
    
                    } label: {
                        VStack(spacing: 3) {
                            Image(systemName: items.icon)
                                .symbolVariant(.fill)
                                .font(.system(size: 25, weight: .bold, design: .serif))
                                .frame(width: 44, height: 30)
                                .padding(.vertical, 4)
                            Text(items.text)
                                .font(.caption2)
                                .lineLimit(1)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .foregroundStyle(selectedTab == items.tab ? .primary : .secondary)
                }
            }
            .padding(.horizontal, 8)
           
        }
        }
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabView()
    }
}












//            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 34, style: .continuous).fill(selectedTab == items.tab ? color.opacity(0.5) : .clear))
//            .background(
//                HStack (spacing: 50)
//                {
//                    if selectedTab == .nowPlaying { Spacer() }
//                    if selectedTab == .popular {
//                        Spacer()
//                    }
////                    if selectedTab == .trending {
////                        Spacer(minLength: 0)
////                    }
//                    Circle().fill(color).frame(width: 80)
//
//                    if selectedTab == .nowPlaying { Spacer()
//                        }
//                    if selectedTab == .upcoming {
//                        Spacer()
//                        Spacer()
//
//                    }
//                }
//                    .padding(.horizontal, 8)
//            )
