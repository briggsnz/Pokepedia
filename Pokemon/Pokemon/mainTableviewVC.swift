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
            self.tableView.reloadData()
        }, fail: {error in // error downloading so load local file
            let bundle = Bundle(for: Pokemon.self)
            
            // use local data instead
            Pokemon.useLocalData(bundle: bundle, success: {newPokemonGroup in
                self.pokemonGroup = newPokemonGroup
                self.tableView.reloadData()
                
                // Display an alert explaining that local values are being used
                Helper.showAlert(VC: self ,title: "Error connecting to server", message: "Loading stored pokemon")
            }, fail: {error in // local data error
                print("call failed with error: \(error.localizedDescription)")
            })
            
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// Sets number of rows in section
    /// if inSearch mode == true then returns the number of rows in filtered list
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if inSearchMode {
            return filterPokemonGroup.count
        } else {
            return pokemonGroup.count
        }
    }
    
    /// configures cell
    /// if in search mode then retrieve data from filtered list
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath)//UITableViewCell()
        
        if inSearchMode {
            cell.textLabel?.text = filterPokemonGroup[indexPath.row].name?.capitalized
        } else {
            cell.textLabel?.text = pokemonGroup[indexPath.row].name?.capitalized
        }
        return cell
    }

    /// if row is touched them seque
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showPokemonDetailsSegue", sender: nil)
    }
    
    
    // if search bar is edited
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // no text - turn of editing mode
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            tableView.reloadData()
            view.endEditing(true)
            
        // text filter - results and reload
        } else {
            inSearchMode = true
            let lower = searchBar.text!.lowercased()
            filterPokemonGroup = pokemonGroup.filter({$0.name?.range(of: lower) != nil})
            tableView.reloadData()
        }
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
                // do the work here
                if inSearchMode {
                    destination.pokemon = filterPokemonGroup[indexPath.row]
                } else {
                    destination.pokemon = pokemonGroup[indexPath.row]
                }
            }
        }
    }

}

