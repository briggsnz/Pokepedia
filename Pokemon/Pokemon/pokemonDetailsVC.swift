//
//  pokemonDetailsVC.swift
//  Pokemon
//
//  Created by Craig Briggs on 2/09/17.
//  Copyright © 2017 Craig Briggs. All rights reserved.
//

import UIKit

class pokemonDetailsVC: UIViewController {

    var pokemon: Pokemon?
    var pokemonDetails: PokemonDetails!
    
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var weightValue: UILabel!
    @IBOutlet weak var heightValue: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    
    /// Display an alert explaining that data cannot be found and segue back
    func createAlert(){
        let alert = UIAlertController(title: "Error connecting to server", message: "Failed to find details about selected Pokemon", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
            _ = self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: false, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        // Set the navigation bar title and style
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Pokemon Solid", size: 28)!, NSForegroundColorAttributeName: UIColor.orange]
       
        // set title text
        if let name = pokemon?.name {
            pokemonName.text = name.capitalized
            self.title = "Pokepedia"
        }
        
        // if url is OK and valid download details and update info
        if let url = pokemon?.url {
            pokemonDetails = PokemonDetails()
            PokemonDetails.downloadPokemonDetails (dataURLPass: url, success: {newPokemonDetails in
                self.pokemonDetails = newPokemonDetails
                self.updateDetails()
            }, fail: {error in
                self.createAlert()
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// Update details on screen
    func updateDetails () {
        weightValue.text = "\(pokemonDetails.weight!)"
        heightValue.text = "\(pokemonDetails.height!)"
        
        // download image
        PokemonDetails.downloadImage(imageURL: pokemonDetails.imageURL!, success: {image in
            self.pokemonImage.image = image
        }, fail: {})
    }
}
