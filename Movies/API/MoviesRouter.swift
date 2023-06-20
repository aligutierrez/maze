//
//  MoviesRouter.swift
//  Movies
//
//  Created by Ali Gutierrez on 6/19/23.
//

import Alamofire
import Foundation

enum MazeRouter: APIConfiguration {
    
    case shows(Int)
    case showsWithSearch(String)
    case showSeasons(Int)
    case showEpisodesBySeason(Int)
    case showEpisodes(Int)
    case peopleSearch(String)
    case showsFromPerson(Int)
    case showById(Int)
    
    
    // MARK: BaseURL
    var baseUrl: URL { BackendEnvironment.baseURL }

    
    // MARK: HTTPMethod

    internal var method: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
    
    // MARK: Path

    internal var path: String {
        switch self {
        case .shows(let page):
            return "/shows?page=\(page)"
        case .showsWithSearch(let searchTerm):
            return "/search/shows?q=\(searchTerm)"
        case .showSeasons(let id):
            return "/shows/\(id)/seasons"
        case .showEpisodes(let id):
            return "/shows/\(id)/episodes"
        case .showEpisodesBySeason(let season):
            return "/seasons/\(season)/episodes"
        case .peopleSearch(let searchTerm):
            return "/search/people?q=\(searchTerm)"
        case .showsFromPerson(let id):
            return "/people/\(id)/castcredits"
        case .showById(let id):
            return "shows/\(id)"
        }
    }
    
    
    // MARK: Parameters

    internal var parameters: Parameters? {
        switch self {
        default:
            return nil
        }
    }
    
    internal var customParameters: (contentType: String?, data: Data?)? {
        return nil
    }
    
    
    // MARK: ContentTypes

    var additionalContentTypes: [String] { [] }
}
