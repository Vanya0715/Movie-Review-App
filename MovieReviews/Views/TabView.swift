//
//  TabView.swift
//  MovieReviews
//
//  Created by Divyansh Dwivedi on 10/05/22.
//

import SwiftUI

struct TabView: View {
    
    @State var selectedTab: Tab = .home
    @State var color: Color = .teal
    
    var body: some View {
      
        ZStack(alignment: .bottom) {
            Group{
                switch selectedTab {
                case.home:
                    HomeScreenView()
                case.movie:
                    MovieListView()
                case.search:
                    MovieSearchView()
                }
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
           
            HStack {
                ForEach(tabItems) { items in
                    Button {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            selectedTab = items.tab
                            color = items.color
                        }
                    } label: {
                        VStack(spacing: 0) {
                            Image(systemName: items.icon)
                                .symbolVariant(.fill)
                                .font(.body.bold())
                                .frame(width: 44, height: 29)
                            Text(items.text)
                                .font(.caption2)
                                .lineLimit(1)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .foregroundStyle(selectedTab == items.tab ? .primary : .secondary)
                }
            }.padding(.horizontal, 8)
            .padding(.top, 14)
            .frame( height: 88, alignment: .top)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 34, style: .continuous))
            .background(
                HStack{
                    if selectedTab == .movie { Spacer() }
                    if selectedTab == .search {
                        Spacer()
                    }
                    
                    Circle().fill(color).frame(width: 130)
                    if selectedTab == .home { Spacer() }
                    if selectedTab == .movie {
                        Spacer()
                    }
                }
                    .padding(.horizontal, 8)
            )
            .frame(maxHeight: .infinity, alignment: .bottom)
            .ignoresSafeArea()
            
        }
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabView()
    }
}
