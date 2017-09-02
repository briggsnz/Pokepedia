//
//  Pokeman.swift
//  Pokemon
//
//  Created by Craig Briggs on 2/09/17.
//  Copyright © 2017 Craig Briggs. All rights reserved.
//

import Foundation

class Pokemon {
    let name : String?
    let url : String?
    
    init(name: String, url: String) {
        self.name = name
        self.url = url
    }
    
    init(pokemonDictionary: [String:Any]) {
        self.name = pokemonDictionary["name"] as? String
        self.url = pokemonDictionary["url"] as? String
    }
}
