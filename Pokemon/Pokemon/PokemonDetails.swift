//
//  PokemonDetails.swift
//  Pokemon
//
//  Created by Craig Briggs on 2/09/17.
//  Copyright © 2017 Craig Briggs. All rights reserved.
//

import Foundation

//  HTTP networking library written in Swift - https://github.com/Alamofire/Alamofire
import Alamofire
// An image component library for Alamofire - https://github.com/Alamofire/AlamofireImage
import AlamofireImage

class PokemonDetails {
    var name:String?
    var height:Int?
    var weight:Int?
    var imageURL: String?
    let dataURL: String?
    
    init() {
        self.dataURL = ""
        self.name = ""
        self.weight = 0
        self.height = 0
        self.imageURL = ""
    }
    
    func downloadPokemonDetails(dataURL: String, completed: @escaping () -> ()){
        let detailsURL = URL(string: dataURL)!
        let decodeJson = DecodeJson()
        
        Alamofire.request(detailsURL).responseJSON{ response in
            if let value = response.result.value {
                decodeJson.decodePokemonDetails(list: value, pokemonDetails: self)
            }
           completed()
        }
        
    }
    
    func downloadImage(completed: @escaping (UIImage) -> ()) {
        Alamofire.request(self.imageURL!).responseImage { response in
            if let image = response.result.value {
                completed(image)
            }
        }
    }
    
}
