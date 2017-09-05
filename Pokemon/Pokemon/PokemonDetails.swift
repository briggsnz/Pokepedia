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


/// Deals with details of one specific pokemon
class PokemonDetails {
    var name:String?
    var height:Int?
    var weight:Int?
    var imageURL: String?
    var dataURL: String?
    
    /// Download details about a specific Pokemon
    ///
    /// - Parameters:
    ///   - dataURLPass: URL to find details
    ///   - success: callback for successful download
    ///   - fail: callback for failed download
    static func downloadPokemonDetails(dataURLPass: String, success: @escaping (PokemonDetails) -> (), fail: @escaping (NSError?) -> ())  -> Void{
        let decodeJson = DecodeJson()
        
        // use Alamofire to download data
        Alamofire.request(dataURLPass).validate().responseJSON { response in
            switch response.result{
                
            // if successful decode and success callBack, else fail callBack
            case .success:
                if let value = response.result.value {
                    if let pokemonDetails = decodeJson.decodePokemonDetails(list: value) {
                        success(pokemonDetails)
                    } else {
                        fail(nil)
                    }
                }
            case .failure(let error as NSError):
                fail(error)
            default:
                break
            }
        }
    }
    

    /// Download image for a specific Pokemon
    ///
    /// - Parameters:
    ///   - imageURL: URL for image of specific pokemon
    ///   - success: callback for successful download
    ///   - fail: callback for failed download
    static func downloadImage(imageURL: String, success: @escaping (UIImage) -> (), fail: @escaping () -> ()) {

        // use Alamofire to download data
        Alamofire.request(imageURL).validate().responseImage { response in
            switch response.result{
            case .success:
                if let image = response.result.value {
                    success(image)
                }
            case .failure(_ as NSError):
                fail()
            default:
                break
            }
        }
    }
}
