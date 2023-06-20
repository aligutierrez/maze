//
//  ShowRowView.swift
//  Movies
//
//  Created by Ali Gutierrez on 6/19/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct ShowRowView: View {
    @StateObject var viewModel = ShowRowViewModel()
    var show: Show
    @State private var isFavorited = false
    
    
    var body: some View {
        HStack {
            WebImage(url: show.poster)
                .resizable()
                .indicator(.activity)
                .scaledToFill()
                .frame(width: 75, height: 75)
                .clipped()
            VStack {
                Text(show.name)
                Spacer()
            }
            Spacer()
            Button(action: {
                viewModel.favorite()
            }, label: {
                if isFavorited || viewModel.favedShows.contains(show) {
                    Image(systemName: "heart.fill")
                } else {
                    Image(systemName: "heart")
                }
            })
        }
        .onAppear {
            setupBindings()
        }
    }
    private func setupBindings() {
        viewModel.onFavoritedChange = {isFavorited in
            self.setFavoriteButtonState(isFavorited: isFavorited)
        }
    }

    private func setFavoriteButtonState(isFavorited: Bool) {
        self.isFavorited = isFavorited || viewModel.favedShows.contains(show)
        
        if isFavorited {
            viewModel.removeFavoriteShow(show: show)
        } else {
            viewModel.addFavorite(show: show)
        }
    }
}

