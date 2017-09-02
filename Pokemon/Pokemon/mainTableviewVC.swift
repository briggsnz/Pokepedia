//
//  mainTableviewVC.swift
//  Pokemon
//
//  Created by Craig Briggs on 2/09/17.
//  Copyright © 2017 Craig Briggs. All rights reserved.
//

import UIKit
import Alamofire

class mainTableviewVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    let array = ["one", "two", "three", "four", "five", "six"]
    var pokemonGroup = [Pokemon]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Pokemon.downloadPokemonData{newPokemonGroup in
            self.pokemonGroup = newPokemonGroup
            self.tableView.reloadData()
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonGroup.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath)//UITableViewCell()
        cell.textLabel?.text = pokemonGroup[indexPath.row].name
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected")
        print(pokemonGroup[indexPath.row].name!)
        print(pokemonGroup[indexPath.row].url!)
        
        performSegue(withIdentifier: "showPokemonDetailsSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
        
        if let destination = segue.destination as? pokemonDetailsVC {
            if let indexPath = tableView.indexPathForSelectedRow {
                // do the work here
               destination.pokemon = pokemonGroup[indexPath.row]
            }
        }
    }

}

