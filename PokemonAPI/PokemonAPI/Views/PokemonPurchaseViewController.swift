//
//  PokemonPurchaseViewController.swift
//  PokemonAPI
//
//  Created by Alex Thompson on 4/17/21.
//

import UIKit

class PokemonPurchaseViewController: UIViewController {
    
    // MARK: - OUTLETS
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var saveButton: UIBarButtonItem!
    @IBOutlet var buyButton: UIButton!
    
    // MARK: - PROPERTIES
    
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    
    var pokemonController: PokemonController? {
        didSet {
            updateViews()
        }
    }
    
    func hideKeyboard() {
        searchBar.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
        
        searchBar.delegate = self
    }
    
    // MARK: UPDATE VIEWS
    
    func updateViews() {
        
    }
    // MARK: - ACTIONS
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PokemonPurchaseViewController: UISearchBarDelegate {
    
}
