//
//  DetailViewModel.swift
//  Movies
//
//  Created by Ali Gutierrez on 6/19/23.
//

import SwiftUI
import Combine

class DetailViewModel: ObservableObject, Identifiable {
    
    @Published var episodes: [Episode] = [Episode]()
    @Published var filteredEpisodes: [Episode] = [Episode]()
    @Published var episodesBySeason: [Episode] = [Episode]()
    @Published var seasonsCount: Int = 0
    @Published var isLoadingPage = false

    func getEpisodes(for showId: Int) {
        guard !isLoadingPage else {
            return
        }
        
        isLoadingPage = true
        serviceLocator
            .webService
            .getShowEpisodes(showId: showId, errorType: NetworkError.self)
            .execute(onSuccess: { episodes in
                self.episodes = episodes
                let seasons = Set(episodes.map { $0.season })
                self.seasonsCount = seasons.count
                self.getEpisodesBySeason(for: 1)
                self.isLoadingPage = false
            }, onFailure: {error in
                print(error.localizedDescription)
                self.isLoadingPage = false
            })
    }
    
    func getEpisodesBySeason(for season: Int) {
        self.filteredEpisodes.removeAll()
        var tempEpisodes = [Episode]()
        for episode in episodes {
            if episode.season == season {
                tempEpisodes.append(episode)
            }
        }
        self.filteredEpisodes = tempEpisodes
    }
    
}

