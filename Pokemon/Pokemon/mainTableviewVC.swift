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
    
    var pokemonGroup : [Pokemon]!
    var filterPokemonGroup : [Pokemon]!

    override func viewDidLoad() {
        // Do any additional setup after loading the view, typically from a nib.
        
        pokemonGroup = [Pokemon]()
        filterPokemonGroup = [Pokemon]()
        
        // Set the navigation bar title and style
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Pokemon Solid", size: 28)!, NSForegroundColorAttributeName: UIColor.orange]
        navigationController?.navigationBar.barTintColor = UIColor.yellow
       
        // Download from server, if server is unavailable for some reason then use local files
        Pokemon.downloadPokemonData(success: {newPokemonGroup in // successfully downloaded content
            self.pokemonGroup = newPokemonGroup
            self.filterPokemonGroup = self.pokemonGroup
            self.tableView.reloadData()
        }, fail: {error in // error downloading so load local file
            let bundle = Bundle(for: Pokemon.self)
            
            // use local data instead
            Pokemon.useLocalData(bundle: bundle, success: {newPokemonGroup in
                self.pokemonGroup = newPokemonGroup
                self.filterPokemonGroup = self.pokemonGroup
                self.tableView.reloadData()
                
                // Display an alert explaining that local values are being used
                Helper.showAlert(VC: self ,title: "Error connecting to server", message: "Loading stored pokemon")
            }, fail: {error in // local data error
                print("call failed with error: \(error.localizedDescription)")
            })
            
        })
        
        filterPokemonGroup = pokemonGroup
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// Sets number of rows in section
    /// Returns the count of filterPokemonGroup as this is always the group we are using
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterPokemonGroup.count
    }
    
    /// configures cell
    /// if in search mode then retrieve data from filtered list
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath)//UITableViewCell()
        
        cell.textLabel?.text = filterPokemonGroup[indexPath.row].name?.capitalized
        return cell
    }

    /// if row is touched them seque
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showPokemonDetailsSegue", sender: nil)
    }
    
    
    // if search bar is edited
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        // When there is no text, filterPokemonGroup is the same as pokemonGroup
        // When user has entered text into the search box
        // Use the filter method to iterate over all items in the data array
        // For each item, return true if the item should be included and false if the
        // item should NOT be included. Then we reload the data
        let lower = searchBar.text!.lowercased()
        filterPokemonGroup = searchText.isEmpty ? pokemonGroup : pokemonGroup.filter({$0.name?.range(of: lower) != nil})
        tableView.reloadData()

    }
    
    // hide keyboard if scrolled
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
   
    // hide keyboard if "Search" pressed
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
  
    // segue to next storyboard
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        view.endEditing(true)
        
        // set back text and style
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
        self.navigationController?.navigationBar.tintColor = UIColor.orange
        
        // set values in pokemonDetailsVC storyboard
        if let destination = segue.destination as? pokemonDetailsVC {
            if let indexPath = tableView.indexPathForSelectedRow {
                destination.pokemon = filterPokemonGroup[indexPath.row]
            }
        }
    }

}

