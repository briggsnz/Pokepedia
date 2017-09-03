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
                    let newPokemon =  Pokemon(pokemonDictionary: poke)
                    pokemonGroup.append(newPokemon)
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
    func decodePokemonDetails (list: Any, pokemonDetails: PokemonDetails) -> () {
        if let dict = list as? Dictionary<String, AnyObject> {
            if let name = dict["name"] as? String {
                pokemonDetails.name = name.capitalized
            }
            if let height = dict["height"] as? Int {
                pokemonDetails.height = height
            }
            if let weight = dict["weight"] as? Int {
                pokemonDetails.weight = weight
            }
            if let sprites = dict["sprites"] as? Dictionary<String, AnyObject> {
                if let image = sprites["front_shiny"] as? String {
                    pokemonDetails.imageURL = image
                }
            }
        }
    }
}
