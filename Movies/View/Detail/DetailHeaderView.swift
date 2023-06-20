//
//  DetailHeaderView.swift
//  Movies
//
//  Created by Ali Gutierrez on 6/19/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailHeaderView: View {
    let show: Show
    let genre: String
    var body: some View {
        HStack {
            WebImage(url: show.poster)
                .resizable()
                .indicator(.activity)
                .scaledToFill()
                .frame(width: 75, height: 75, alignment: .topLeading)
                .clipped()
            VStack {
                Text(show.name)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .font(.headline)
                Text(genre)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .font(.subheadline)
            }
            .frame(alignment: .top)
            
            Spacer()
        }
        .padding(.horizontal, 16)
    }
}
