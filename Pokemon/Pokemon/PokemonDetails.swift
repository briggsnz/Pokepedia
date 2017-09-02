//
//  PokemonDetails.swift
//  Pokemon
//
//  Created by Craig Briggs on 2/09/17.
//  Copyright © 2017 Craig Briggs. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage
typealias DetailsDownloadComplete = () -> ()


class PokemonDetails {
    var name:String?
    var height:Int?
    var weight:Int?
    var imageURL: String?
    let dataURL: String?
    
    init(dataURL: String) {
        self.dataURL = dataURL
        self.name = ""
        self.weight = 0
        self.height = 0
        self.imageURL = ""
    }
    
    func downloadPokemonDetails(completed: @escaping DetailsDownloadComplete){
        let detailsURL = URL(string: dataURL!)!
        Alamofire.request(detailsURL).responseJSON{ response in
            let result = response.result
            print(result)
            //print(response)
            if let dict = result.value as? Dictionary<String, AnyObject> {
                print(dict)
            
                if let name = dict["name"] as? String {
                    self.name = name.capitalized
                    print(self.name!)
                }
                if let height = dict["height"] as? Int {
                    self.height = height
                    print(self.height!)
                }
                if let weight = dict["weight"] as? Int {
                    self.weight = weight
                    print(self.weight!)
                }
                
                if let sprites = dict["sprites"] as? Dictionary<String, AnyObject> {
                    if let image = sprites["front_shiny"] as? String {
                        self.imageURL = image
                    }
                }

            }
           completed()
        }
        
    }
    
    func downloadImage() {
        if let thumbnailURL = imageURL {
            let networkService = NetworkService(url: thumbnailURL)
            networkService.downloadImage({ (imageData) in
                let image = UIImage(data: imageData as Data)
                DispatchQueue.main.async(execute: {
                    self.thumbnailImageView.image = image
                })
            })
        }
    }
    
}
