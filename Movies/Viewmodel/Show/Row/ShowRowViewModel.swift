//
//  ShowRowViewModel.swift
//  Movies
//
//  Created by Ali Gutierrez on 6/20/23.
//

import Foundation

class ShowRowViewModel: ObservableObject, Identifiable {
    @Published var favedShows = [Show]()

    var isFavorited = false {
        didSet {
            onFavoritedChange?(isFavorited)
        }
    }
    var onFavoritedChange: ((_ isFavorited: Bool) -> Void)?
    var onFavoriteEnabledChange: ((_ isFavorited: Bool) -> Void)?
    var onFavoriteTap: (() -> Void)?

    
    func favorite() {
        isFavorited.toggle()
        onFavoriteTap?()
    }
    
    func addFavorite(show: Show) {
        if !favedShows.contains(show) {
            favedShows.append(show)
        }
    }
    
    func removeFavoriteShow(show: Show) {
        guard let index = favedShows.firstIndex(of: show) else {
            return
        }
        favedShows.remove(at: index)
    }
}
