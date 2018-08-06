//
//  Media.swift
//  Exercise-Intive
//
//  Created by David Munoz on 01/08/2018.
//  Copyright © 2018 David Munoz. All rights reserved.
//

import ObjectMapper

class Media: Mappable {
    var trackName : String?
    var disckImage : String?
    var previewUrl: String?

    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        trackName <- map["trackName"]
        disckImage <- map["artworkUrl100"]
        previewUrl <- map["previewUrl"]

    }

}
