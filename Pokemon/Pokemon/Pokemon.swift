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

/// Pokemon class
///
class Pokemon {
    let name : String?
    let url : String?
    
    /// Convenience initializer
    ///
    /// - Parameter pokemonDictionary: dictionary containing 'name' and 'url' (see above)
    init(pokemonDictionary: [String:Any])  {
        self.name = pokemonDictionary["name"] as? String
        self.url = pokemonDictionary["url"] as? String
    }

    
    /// Download Pokemon data from URL
    ///
    /// - Parameters:
    ///   - downloadURL: URL to of where to connect, used to override for testing
    ///   - success: callback for successful download
    ///   - fail: callback for failed download
    static func downloadPokemonData (downloadURL:String? = "http://pokeapi.co/api/v2/pokemon/?limit=30&offset=1", success: @escaping ([Pokemon]) -> (), fail: @escaping (NSError) -> ()) -> Void {
        var pokemonGroup = [Pokemon]()
        let decodeJson = DecodeJson()

        Alamofire.request(downloadURL!).responseJSON { response in
            switch response.result{
            case .success:
                if let value = response.result.value {
                    pokemonGroup = decodeJson.decodeList(list: value)
                }
                success(pokemonGroup)
                break
            case .failure(let error as NSError):
                fail(error)
                break
            default:
                print("I have an unexpected case.")
            }
        }
    }
    
    /// Usle local data instead
    ///
    /// - Parameters:
    ///   - bundle: Where to find local data (used for testing)
    ///   - fileName: Where to find local data (used for testing)
    ///   - success: callback for successful download
    ///   - fail: callback for failed download
    static func useLocalData(bundle: Bundle, fileName: String = "pokemonList", success: @escaping ([Pokemon]) -> (), fail: @escaping (NSError) -> ()) {
        var pokemonGroup = [Pokemon]()
        let decodeJson = DecodeJson()
        
        //let bundle = Bundle(for: Pokemon.self)
        let jsonFile = bundle.path(forResource: fileName, ofType: "json")
        let jsonFileURL = URL(fileURLWithPath: jsonFile!)
        let jsonData = try? Data(contentsOf: jsonFileURL)
        
        if let data = jsonData {
            do {
                let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String : AnyObject]
                pokemonGroup = decodeJson.decodeList(list: jsonDictionary!)
                success(pokemonGroup)
            } catch let error as NSError {
                fail(error)
            }
        }
    }
}











