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
    var pokemodDetails: PokemonDetails!
    
    @IBOutlet weak var weightValue: UILabel!
    @IBOutlet weak var heightValue: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // print(pokemon?.name)
        
        if let name = pokemon?.name {
            self.title = name.capitalized
        }
        
        if let url = pokemon?.url {
             pokemodDetails = PokemonDetails(dataURL: url)
            pokemodDetails.downloadPokemonDetails {_ in 
               // self.updateMainUI()
                self.updateDetails()
           
            }
        }
       
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateDetails () {
        weightValue.text = "\(pokemodDetails.weight!)"
        heightValue.text = "\(pokemodDetails.height!)"
        pokemodDetails.downloadImage{image in
            self.pokemonImage.image = image
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
