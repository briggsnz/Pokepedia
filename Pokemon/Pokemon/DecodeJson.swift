//
//  DecodeJson.swift
//  Pokemon
//
//  Created by Craig Briggs on 3/09/17.
//  Copyright © 2017 Craig Briggs. All rights reserved.
//

import Foundation

class DecodeJson {
    /// Decodes/Parses Json Data and returns as array of "Pokemon"
    ///
    /// - Parameter list: Raw Json Data
    /// - Returns: List of "Pokemon"
    func decodeList (list: Any ) -> ([Pokemon]){
        var pokemonGroup = [Pokemon]()
        if let dict = list as? Dictionary<String, AnyObject> {
            if let pokemon = dict["results"] as? [Dictionary<String, AnyObject>] {
                for poke in pokemon {
                    do {
                        guard let _ = poke["name"] as? String,
                            let _ = poke["url"] as? String else {
                                // throw("Mismatch" as NSError)
                                continue
                        }
                        let newPokemon = Pokemon(pokemonDictionary: poke)
                        pokemonGroup.append(newPokemon)
                    }
                    
                }
            }
        }
       return pokemonGroup
    }
    
    /// Decodes details of a specific pokemon from Json data and mutates data of given instance
    /// of PokemonDetails
    ///
    /// - Parameters:
    ///   - list: Raw Json Data
    ///   - pokemonDetails: instance of PokemonDetails to be mutated
    func decodePokemonDetails (list: Any) -> (PokemonDetails?) {
        let pokemonDetails = PokemonDetails()
        if let dict = list as? Dictionary<String, AnyObject> {
            guard let name = dict["name"] as? String,
                let height = dict["height"] as? Int,
                let weight = dict["weight"] as? Int,
                let sprites = dict["sprites"] as? Dictionary<String, AnyObject>,
                let image = sprites["front_shiny"] as? String else {
                    return nil
            }
            
            pokemonDetails.name = name.capitalized
            pokemonDetails.height = height
            pokemonDetails.weight = weight
            pokemonDetails.imageURL = image
            
        }
        return pokemonDetails
    }
}
