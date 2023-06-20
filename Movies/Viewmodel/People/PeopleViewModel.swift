//
//  PeopleViewModel.swift
//  Movies
//
//  Created by Ali Gutierrez on 6/19/23.
//

import SwiftUI
import Combine

class PeopleViewModel: ObservableObject, Identifiable {
    
    @Published var people: [Person] = [Person]()
    @Published var searchText: String = ""
    @Published var isLoadingPage = false

    
    func getPeople(with searchTerm: String) {
        guard !isLoadingPage else {
            return
        }
        
        isLoadingPage = true
        serviceLocator
            .webService
            .getPeople(searchTerm: searchTerm, errorType: NetworkError.self)
            .execute(onSuccess: { people in
                self.people = people
                self.isLoadingPage = false
            }, onFailure: {error in
                print(error.localizedDescription)
                self.isLoadingPage = false
            })
    }
}

