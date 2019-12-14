//
//  URLRequest+HTTPMethods.swift
//  MovieDB
//
//  Created by Hariel Giacomuzzi on 14/12/19.
//  Copyright © 2019 Hariel Giacomuzzi. All rights reserved.
//

import Foundation

extension URLRequest {

    ///HTTP method
    ///
    ///[Online Reference](https://www.w3.org/Protocols/rfc2616/rfc2616-sec9.html)
    public enum HTTPMethod: String {

        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
        case head = "HEAD"
        case options = "OPTIONS"
        case trace = "TRACE"
        case connect = "CONNECT"
    }

    public var method: HTTPMethod? {

        get {

            guard let httpMethod = self.httpMethod else { return nil }
            let method = HTTPMethod(rawValue: httpMethod)
            return method
        }

        set {

            self.httpMethod = newValue?.rawValue
        }
    }
}

extension URLRequest {

    public init(url: URL, method: HTTPMethod, contentType: String?) {

        self.init(url: url)

        self.method = method
        self.setValue(contentType, forHTTPHeaderField: "Content-Type")
    }

    public init(url: URL, method: HTTPMethod, contentType: String?, body: Data?) {

        self.init(url: url)

        self.method = method
        self.setValue(contentType, forHTTPHeaderField: "Content-Type")
        self.httpBody = body
    }

    public init(url: URL, method: HTTPMethod, contentType: String?, cachePolicy: CachePolicy, timeoutInterval: TimeInterval) {

        self.init(url: url, cachePolicy: cachePolicy, timeoutInterval: timeoutInterval)

        self.method = method
        self.setValue(contentType, forHTTPHeaderField: "Content-Type")
    }
}

