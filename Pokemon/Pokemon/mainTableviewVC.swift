//
//  mainTableviewVC.swift
//  Pokemon
//
//  Created by Craig Briggs on 2/09/17.
//  Copyright © 2017 Craig Briggs. All rights reserved.
//

import UIKit
import Alamofire

class mainTableviewVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var inSearchMode = false
    
    var pokemonGroup = [Pokemon]()
    var filterPokemonGroup = [Pokemon]()
    
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
        if inSearchMode {
            return filterPokemonGroup.count
        } else {
            return pokemonGroup.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath)//UITableViewCell()
        if inSearchMode {
            cell.textLabel?.text = filterPokemonGroup[indexPath.row].name?.capitalized
        } else {
            cell.textLabel?.text = pokemonGroup[indexPath.row].name?.capitalized
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        
        performSegue(withIdentifier: "showPokemonDetailsSegue", sender: nil)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            
            inSearchMode = false
            tableView.reloadData()
            view.endEditing(true)
            
        } else {
            
            inSearchMode = true
            
            let lower = searchBar.text!.lowercased()
            
            filterPokemonGroup = pokemonGroup.filter({$0.name?.range(of: lower) != nil})
            tableView.reloadData()
            
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
   
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
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

