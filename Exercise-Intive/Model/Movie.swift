//
//  Movie.swift
//  Exercise-Intive
//
//  Created by David Munoz on 01/08/2018.
//  Copyright © 2018 David Munoz. All rights reserved.
//

import UIKit
import ObjectMapper

class Movie: Media {

    var description : String?
    required init?(map: Map){
        super.init(map: map)
        
    }
    override func mapping(map: Map) {
        super.mapping(map: map)
        description <- map["longDescription"]
    }
}
