//
//  FilterTypes.swift
//  Exercise-Intive
//
//  Created by David Munoz on 01/08/2018.
//  Copyright © 2018 David Munoz. All rights reserved.
//

import UIKit

enum FilterTypes:String {
    case music = "song"
    case tvShow = "tvEpisode"
    case movie = "movie"

    
    static let allValues = [music,tvShow,movie]
}
