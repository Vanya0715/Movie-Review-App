//
//  offsetModifier.swift
//  MovieReviews
//
//  Created by Divyansh Dwivedi on 06/07/22.
//

import SwiftUI

struct OffsetModifier: ViewModifier {
    
    @Binding var offset: CGFloat
    
    func body(content: Content) -> some View {
        
        content
            .overlay(
                GeometryReader { proxy -> Color in
                    let minY = proxy.frame(in: .global).minY
                    DispatchQueue.main.async {
                        self.offset = minY
                    }
                    return Color.clear
                }
                ,alignment: .top
            )
    }
}
