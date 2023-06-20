//
//  MainViewModel.swift
//  Movies
//
//  Created by Ali Gutierrez on 6/19/23.
//

import SwiftUI
import Combine

class MainViewModel: ObservableObject, Identifiable {
    
    @Published var shows: [Show] = [Show]()
    @Published var searchText: String = ""
    @Published var page = 0
    @Published var isLoadingPage = false
    
    init() {
        getShows()
    }
    
    func loadMoreContentIfNeeded(currentItem show: Show?) {
        guard let show = show else {
            getShows()
            return
        }
        
        let thresholdIndex = shows.index(shows.endIndex, offsetBy: 0)
        if shows.firstIndex(where: { $0.id == show.id }) == thresholdIndex - 1{
            getShows()
        }
    }
    
    func getShows() {
        guard !isLoadingPage else {
            return
        }
        
        isLoadingPage = true
        page += 1
        serviceLocator
            .webService
            .getShows(page: page, errorType: NetworkError.self)
            .execute(onSuccess: { shows in
                self.shows = self.shows + shows
                self.isLoadingPage = false
            }, onFailure: {error in
                print(error.localizedDescription)
                self.isLoadingPage = false
            })
    }
    
    func getShows(with searchTerm: String) {
        guard !isLoadingPage else {
            return
        }
        
        isLoadingPage = true
        var searchResults = [Show]()
        self.shows.removeAll()
        serviceLocator
            .webService
            .getShows(searchTerm: searchTerm, errorType: NetworkError.self)
            .execute(onSuccess: { items in
                for item in items {
                    searchResults.append(item.show)
                }
                self.shows = searchResults
                self.isLoadingPage = false
            }, onFailure: {error in
                print(error.localizedDescription)
                self.isLoadingPage = false
            })
    }
}
