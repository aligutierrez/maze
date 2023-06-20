//
//  Constants.swift
//  Movies
//
//  Created by Ali Gutierrez on 6/19/23.
//

import Foundation

enum Constants {
    enum Application {
        static let shortVersionKey = "CFBundleShortVersionString"
        static let versionKey = "CFBundleVersion"
        static let bundleDisplayName = "CFBundleDisplayName"
        static let bundleIdentifier = "CFBundleIdentifier"
    }

    enum ErrorMessage {
        static let failOverErrorMessage = "Something went wrong, please try again."
    }
}

enum HTTPHeaderField {
    static let authorization = "Authorization"
    static let contentType = "Content-Type"
    static let acceptType = "Accept"
    static let acceptEncoding = "Accept-Encoding"
    static let acceptLanguage = "Accept-Language"
    static let requireLanguage = "Require-Language"
    static let contentDisposition = "Content-Disposition"
}

enum ContentType {
    static let json = "application/json"
    static let javascript = "text/javascript"
    static let formUrlEncoded = "application/x-www-form-urlencoded; charset=utf-8"
    static let jpg = "image/jpg"    // Not a valid MIME type but is needed for backwards compatibility
    static let multipartFormData = "multipart/form-data"
}

enum ContentDisposition {
    static let formData = "form-data"
}

