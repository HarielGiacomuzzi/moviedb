//
//  ImageProvider.swift
//  MovieDB
//
//  Created by Hariel Giacomuzzi on 14/12/19.
//  Copyright © 2019 Hariel Giacomuzzi. All rights reserved.
//

import Foundation

protocol ImageProvider: class {
    func getImage(url: URL, backendService: ServiceType, completion: @escaping (Data?) -> Void)
}

class MovieDBImageProvider: BaseProvider, ImageProvider {

    override init() {
        super.init()
    }

    func getImage(url: URL, backendService: ServiceType = .QA, completion: @escaping (Data?) -> Void) {
        let  imageURL: String = "\(Environment.MovieDBOriginalImageBasePath)\(url)"

        callAPI(queryString: nil, urlPath: imageURL) { (result) in
            switch result {
            case .success(let data):
                completion(data)
            case .failure(let error):
                debugPrint("Error while getting image: \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
}
