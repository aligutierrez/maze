//
//  PeopleDetailViewModel.swift
//  Movies
//
//  Created by Ali Gutierrez on 6/20/23.
//

import SwiftUI
import Combine

class PeopleDetailViewModel: ObservableObject, Identifiable {
    
    @Published var shows: [Show] = [Show]()
    @Published var isLoadingPage = false
    
    private var fetchedshows: [Show] = [Show]()
    
    let group = DispatchGroup()
    
    func getShowsFromPerson(with id: Int) {
        guard !isLoadingPage else {
            return
        }
        var ids: [Int] = [Int]()
        self.shows.removeAll()
        isLoadingPage = true
        serviceLocator
            .webService
            .getShowsFromPerson(id: id, errorType: NetworkError.self)
            .execute(onSuccess: { items in
                for item in items {
                    let showUrlString = item.links.show.href
                    ids.append(showUrlString.split(separator: "/").last.map { Int($0) ?? 0 }! )
                }
                
                for _id in ids {
                    self.group.enter()
                    self.getShowDetails(for: _id)
                    
                }
                self.group.notify(queue: .main) {
                    self.shows = self.fetchedshows.unique()
                    self.isLoadingPage = false
                }
            }, onFailure: {error in
                print(error.localizedDescription)
                self.isLoadingPage = false
            })
    }
    
    func getShowDetails(for id: Int) {
        serviceLocator
            .webService
            .getShowById(id: id, errorType: NetworkError.self)
            .execute(onSuccess: { show in
                self.fetchedshows.append(show)
                self.group.leave()
            }, onFailure: {error in
                print(error.localizedDescription)
                self.isLoadingPage = false
            })
    }
}
