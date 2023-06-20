//
//  APIConfiguration.swift
//  Movies
//
//  Created by Ali Gutierrez on 6/19/23.
//

import Alamofire
import Foundation

protocol APIConfiguration: URLRequestConvertible {
    var baseUrl: URL { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
    var customParameters: (contentType: String?, data: Data?)? { get }
    var additionalContentTypes: [String] { get }
}

extension APIConfiguration {

    // MARK: URLRequestConvertible

    func asURLRequest() throws -> URLRequest {
        let url = URL(string: baseUrl.appendingPathComponent(path).absoluteString.removingPercentEncoding ?? "") ?? URL(string: baseUrl.absoluteString)
        var urlRequest = URLRequest(url: url!)
        print("URL request: \(urlRequest)")
        let bearer = ("\(serviceLocator.userDefaults.string(forKey: .type) ?? "") \(serviceLocator.userDefaults.string(forKey: .token) ?? "")")
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        // Common Headers
        urlRequest.setValue(ContentType.json, forHTTPHeaderField: HTTPHeaderField.acceptType)
        urlRequest.setValue(ContentType.json, forHTTPHeaderField: HTTPHeaderField.contentType)
        urlRequest.setValue(bearer, forHTTPHeaderField: HTTPHeaderField.authorization)
        urlRequest.setValue(serviceLocator.userDefaults.string(forKey: .appLanguage),
                            forHTTPHeaderField: HTTPHeaderField.requireLanguage)
        additionalContentTypes.forEach { urlRequest.addValue($0, forHTTPHeaderField: HTTPHeaderField.acceptType) }
        
        // Parameters
        if let customParameters = customParameters {
            urlRequest.setValue(customParameters.contentType, forHTTPHeaderField: HTTPHeaderField.contentType)
            urlRequest.httpBody = customParameters.data
        } else if let parameters = parameters {
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
                let decoded = String(data: jsonData, encoding: .utf8)!
                urlRequest.httpBody = decoded.data(using: .utf8)
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        

        return urlRequest
    }
}
