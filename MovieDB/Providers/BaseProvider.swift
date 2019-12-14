//
//  BaseProvider.swift
//  MovieDB
//
//  Created by Hariel Giacomuzzi on 14/12/19.
//  Copyright © 2019 Hariel Giacomuzzi. All rights reserved.
//

import Foundation

class BaseProvider {
    func callAPI(
        queryString: Dictionary<String, String>?,
        urlPath: String,
        method: URLRequest.HTTPMethod = .get,
        contentType: String = "Content-Type",
        body: Data? = nil,
        completion: @escaping (Result<Data, Error>) -> Void
    ) {
        var url: URL!
        if let q = queryString {
            url = handleQueryParams(params: q, path: urlPath)
        } else {
            url = URL(string: urlPath)!
        }

        let request = URLRequest(url: url, method: method, contentType: contentType, body: body)

        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            if let e = error {
                completion(.failure(e))
            }
            else if let d = data {
                completion(.success(d))
            }
        })

        task.resume()

    }

    func handleQueryParams(
        params: Dictionary<String, String>,
        path: String
    ) -> URL {
        var iterator = params.makeIterator()
        var url = URLComponents(string: path)!
        var queryItems: [URLQueryItem] = []

        while let value = iterator.next() {
            queryItems.append(URLQueryItem(name: value.key, value: value.value))
        }

        url.queryItems = queryItems
        return url.url!
    }
}
