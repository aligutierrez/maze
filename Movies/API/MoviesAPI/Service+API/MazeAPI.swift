//
//  MazeAPI.swift
//  Movies
//
//  Created by Ali Gutierrez on 6/19/23.
//

import Foundation
import PromisedFuture

typealias MazeAPI = MazeContentAPI


protocol MazeContentAPI {
    func getShows<T>(page: Int, errorType: T.Type) -> Future<[Show]> where T: MazeError
    func getShows<T>(searchTerm: String, errorType: T.Type) -> Future<[ShowSearch]> where T: MazeError
    func getShowById<T>(id: Int, errorType: T.Type) -> Future<Show> where T: MazeError
    func getShowEpisodes<T>(showId: Int, errorType: T.Type) -> Future<[Episode]> where T: MazeError
    func getShowEpisodesBySeason<T>(season: Int, errorType: T.Type) -> Future<[Episode]> where T: MazeError
    func getPeople<T>(searchTerm: String, errorType: T.Type) -> Future<[Person]> where T: MazeError
    func getShowsFromPerson<T>(id: Int, errorType: T.Type) -> Future<[PersonShow]> where T: MazeError
}

extension MazeService: MazeContentAPI {
    
    func getShows<T>(page: Int, errorType: T.Type) -> Future<[Show]> where T: MazeError {
        performRequest(route: MazeRouter.shows(page), errorType: T.self)
    }
    
    func getShows<T>(searchTerm: String, errorType: T.Type) -> PromisedFuture.Future<[ShowSearch]> where T : MazeError {
        performRequest(route: MazeRouter.showsWithSearch(searchTerm), errorType: T.self)
    }
    
    func getShowById<T>(id: Int, errorType: T.Type) -> PromisedFuture.Future<Show> where T : MazeError {
        performRequest(route: MazeRouter.showById(id), errorType: T.self)
    }
    
    func getShowEpisodes<T>(showId: Int, errorType: T.Type) -> PromisedFuture.Future<[Episode]> where T : MazeError {
        performRequest(route: MazeRouter.showEpisodes(showId), errorType: T.self)
    }
    
    func getShowEpisodesBySeason<T>(season: Int, errorType: T.Type) -> PromisedFuture.Future<[Episode]> where T : MazeError{
        performRequest(route: MazeRouter.showEpisodesBySeason(season), errorType: T.self)
    }
    
    func getPeople<T>(searchTerm: String, errorType: T.Type) -> PromisedFuture.Future<[Person]> where T : MazeError {
        performRequest(route:  MazeRouter.peopleSearch(searchTerm), errorType: T.self)
    }
    
    func getShowsFromPerson<T>(id: Int, errorType: T.Type) -> Future<[PersonShow]> where T : MazeError {
        performRequest(route: MazeRouter.showsFromPerson(id), errorType: T.self)
    }
}
