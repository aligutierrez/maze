//
//  MoviesService.swift
//  Movies
//
//  Created by Ali Gutierrez on 6/19/23.
//

import Combine
import Alamofire
import PromisedFuture

class MazeService {

    @Published var isLoading = false

    /// Make a request using the default Alamofire instance.
    /// Request is validated to be in status code range 200..299 and to
    /// Response type is validated to match any of the specified in the Accept HTTP header
    ///
    /// - Parameters:
    ///   - route: The route for the request.
    ///   - decoder: optional decoder for custom decoding off the response object.
    ///   - errorType: The possible error type that the response might return. Must conform to MitwerkenError.
    /// - Returns: A Future with the promise response.
    @discardableResult
    func performRequest<T, U>(route: APIConfiguration,
                              decoder: JSONDecoder = JSONDecoder(),
                              errorType: U.Type) -> PromisedFuture.Future<T> where T: Decodable, U: MazeError {
        print("Type for data response: \(T.self)")
        print("Type for error response: \(U.self)")
        return Future(operation: { completion in
            AF.request(route)
                .validate()
                .responseDecodable(decoder: decoder, completionHandler: { (response: DataResponse<T, AFError>) in
                    print("From: \(route.path)")

                    switch response.result {
                    case .success(let value):
                        completion(.success(value))
                    case .failure(let error):
                        let backendError: BackendResponse<U>? = self.decodeError(from: response)
                        completion(.failure(backendError ?? error))
                    }
                })
        })
    }

    func decodeError<T, U>(from response: AFDataResponse<T>) -> U? where U: MazeError {
        if
            let data = response.data,
            let customError = try? JSONDecoder().decode(U.self, from: data) {
            return customError
        }
        return nil
    }
}

