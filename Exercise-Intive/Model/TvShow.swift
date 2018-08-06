//
//  TvShow.swift
//  Exercise-Intive
//
//  Created by David Munoz on 01/08/2018.
//  Copyright © 2018 David Munoz. All rights reserved.
//

import ObjectMapper

class TvShow: Media {
    var description : String?
    var artistName : String?
    required init?(map: Map){
        super.init(map: map)
        
    }
    override func mapping(map: Map) {
        super.mapping(map: map)
        description <- map["longDescription"]
        artistName <- map["artistName"]
    }
}
