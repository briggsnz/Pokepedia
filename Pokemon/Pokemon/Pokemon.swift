//
//  Pokeman.swift
//  Pokemon
//
//  Created by Craig Briggs on 2/09/17.
//  Copyright © 2017 Craig Briggs. All rights reserved.
//

import Foundation

//  HTTP networking library written in Swift - https://github.com/Alamofire/Alamofire
import Alamofire

class Pokemon {
    let name : String?
    let url : String?
    
    /// Basic initializer
    ///
    /// - Parameters:
    ///   - name: name of pokemon
    ///   - url: url of details for pokemon
    init(name: String, url: String) {
        self.name = name
        self.url = url
    }
    
    /// Convenience initializer
    ///
    /// - Parameter pokemonDictionary: dictionary containing 'name' and 'url' (see above)
    init(pokemonDictionary: [String:Any]) {
        self.name = pokemonDictionary["name"] as? String
        self.url = pokemonDictionary["url"] as? String
    }
    
    /// Download Pokemon data from URL
    ///
    /// - Parameter completed: Closure to be completed when function has finished running
    ///     - Passes back list of downloaded 'Pokemon'
    static func downloadPokemonData (completed: @escaping ([Pokemon]) -> ()) -> Void {
        var pokemonGroup = [Pokemon]()
        let decodeJson = DecodeJson()
        
        let downloadURL = URL(string: "http://pokeapi.co/api/v2/pokemon/?limit=30&offset=1")
        Alamofire.request(downloadURL!).responseJSON { response in
            if let value = response.result.value {
                pokemonGroup = decodeJson.decodeList(list: value)
            }
            completed(pokemonGroup)
        }
    }
    
    static func useLocalData(bundle: Bundle, completed: @escaping ([Pokemon]) -> ()) {
        var pokemonGroup = [Pokemon]()
        let decodeJson = DecodeJson()
        
        //let bundle = Bundle(for: Pokemon.self)
        let jsonFile = bundle.path(forResource: "pokemonList", ofType: "json")
        let jsonFileURL = URL(fileURLWithPath: jsonFile!)
        let jsonData = try? Data(contentsOf: jsonFileURL)
        
        if let data = jsonData {
            do {
                let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String : AnyObject]
                //print( jsonDictionary)
                pokemonGroup = decodeJson.decodeList(list: jsonDictionary!)
                completed(pokemonGroup)
            } catch let error as NSError {
                print("error processing json data: \(error.localizedDescription)")
            }
        }
    }
}











