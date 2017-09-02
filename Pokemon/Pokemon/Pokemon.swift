//
//  Pokeman.swift
//  Pokemon
//
//  Created by Craig Briggs on 2/09/17.
//  Copyright © 2017 Craig Briggs. All rights reserved.
//

import Foundation
import Alamofire

typealias DownloadComplete = ([Pokemon]) -> ()

class Pokemon {
    let name : String?
    let url : String?
    
    init(name: String, url: String) {
        self.name = name
        self.url = url
    }
    
    init(pokemonDictionary: [String:Any]) {
        self.name = (pokemonDictionary["name"] as? String)?.capitalized
        self.url = pokemonDictionary["url"] as? String
    }
    
    static func downloadPokemonData (completed: @escaping DownloadComplete) -> Void {
        var pokemonGroup = [Pokemon]()
        let downloadURL = URL(string: "http://pokeapi.co/api/v2/pokemon/?limit=30&offset=1")
        Alamofire.request(downloadURL!).responseJSON { response in
            let result = response.result
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let pokemon = dict["results"] as? [Dictionary<String, AnyObject>] {
                    for poke in pokemon {
                        let newPokemon =  Pokemon(pokemonDictionary: poke)
                        pokemonGroup.append(newPokemon)
                    }
                }
            }
            completed(pokemonGroup)
        }
    }
}











