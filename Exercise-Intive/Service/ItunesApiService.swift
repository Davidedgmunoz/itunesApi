//
//  ItunesApiService.swift
//  Exercise-Intive
//
//  Created by David Munoz on 01/08/2018.
//  Copyright © 2018 David Munoz. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper

class ItunesApiService: NSObject {

    static let sharedInstance = ItunesApiService()
    
    let urlRequest = "https://itunes.apple.com/search?term="
    func getMediaFor(search: String,forFilter filter: FilterTypes, completionHandler:@escaping (_ result : [Media]?) -> Void){
        let searchNoSpaces = search.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)

        let completeUrlRequest = "\(urlRequest)\(searchNoSpaces)&entity=\(filter.rawValue)"
        print("Requesting to \(completeUrlRequest)")
       let request = Alamofire.request(completeUrlRequest,
                          method: .get,
                          parameters: nil,
                          encoding: JSONEncoding.default,
                          headers: nil)
        apply(filter: filter, to: request, completionHandler: completionHandler)
        }
    
    fileprivate func apply(filter: FilterTypes, to request: DataRequest, completionHandler:@escaping (_ result : [Media]?) -> Void){
        switch filter {
        case .movie:
            request.responseArray(queue: nil,
                                  keyPath: "results", context: nil) { (response: DataResponse<[Movie]>) in
                                    completionHandler(response.value)
            }
        case .music:
            request.responseArray(queue: nil,
                                  keyPath: "results", context: nil) { (response: DataResponse<[Music]>) in
                                    completionHandler(response.value)
            }
        case .tvShow:
            request.responseArray(queue: nil,
                                  keyPath: "results", context: nil) { (response: DataResponse<[TvShow]>) in
                                    completionHandler(response.value)
            }
            
        }
    }
}

