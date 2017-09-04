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
    
    @IBOutlet weak var weightValue: UILabel!
    @IBOutlet weak var heightValue: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    
    func createAlert(){
        let alert = UIAlertController(title: "Error connecting to server", message: "Failed to find details about selected Pokemon", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
            _ = self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: false, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // print(pokemon?.name)
        
        if let name = pokemon?.name {
            self.title = name.capitalized
        }
        
        if let url = pokemon?.url {
            print(url)
            pokemonDetails = PokemonDetails()
            PokemonDetails.downloadPokemonDetails (dataURLPass: url, success: {newPokemonDetails in
                self.pokemonDetails = newPokemonDetails
                self.updateDetails()
            }, fail: {error in
                self.createAlert()
            })
        }
       
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateDetails () {
        weightValue.text = "\(pokemonDetails.weight!)"
        heightValue.text = "\(pokemonDetails.height!)"
        PokemonDetails.downloadImage(imageURL: pokemonDetails.imageURL!, success: {image in
            self.pokemonImage.image = image
        }, fail: {})
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
