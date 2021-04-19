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
    
    var pokemonCost: Double?
    
    var user = User()
    
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
        buyButton.layer.cornerRadius = 10
        
        updateViews()
        
        searchBar.delegate = self
    }
    // MARK: - ACTIONS
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let pokemon = pokemon else { return }
        pokemonController?.addPokemon(pokemon: pokemon)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func buyButton(_ sender: UIButton) {
        if user.balance >= Double(pokemon!.base_experience * 6) * 0.01 {
            performSegue(withIdentifier: "BuySegue", sender: nil)
        } else {
            self.showError()
        }
    }
    
    func showError() {
        DispatchQueue.main.async {
            let ac = UIAlertController(title: "Insufficient Balance", message: "Not enough money to buy \(self.pokemon?.name ?? "pokemon") 🥺", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(ac, animated: true)
        }
    }
    
    func pokemonError() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Pokemon not found", message: "The Pokemon you searched either doesn't exist in our database or you spelled it incorrectly. Check your spelling and try again.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        }
    }

    // MARK: UPDATE VIEWS
    
    func updateViews() {
        guard isViewLoaded else { return }
        guard let pokemonObject = pokemon else {
            title = "Pokemon Search"
            
            return }
        buyButton.isEnabled = true
        title = pokemonObject.name.capitalized
        
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        
        pokemonCost = (Double(pokemonObject.base_experience * 6) * 0.01)
        
        let priceString = formatter.string(from: NSNumber(value: pokemonCost ?? 0))!
        
        priceLabel.text = priceString
        
        pokemonController?.fetchImage(from: pokemonObject.sprites.imageUrl, completion: { pokemonImage in
            DispatchQueue.main.async {
                self.imageView.image = pokemonImage
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "BuySegue" {
            guard let buyVC = segue.destination as? PurchaseViewController else { return }
            buyVC.pokemonController = pokemonController
            buyVC.pokemon = pokemon
            buyVC.pokemonCost = pokemonCost
        }
    }
}

extension PokemonPurchaseViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        hideKeyboard()
        guard let searchTerm = searchBar.text else { return }
        
        pokemonController?.fetchPokemon(pokemonName: searchTerm, completion: { result in
            
            switch result {
            case .success( _):
                guard let pokemon = try? result.get() else { return }
                DispatchQueue.main.async {
                    self.pokemon = pokemon
                }
                
            case.failure( _):
                self.pokemonError()
            }
        })
        
        guard let pokemonImageUrl = pokemon?.sprites.imageUrl else { return }
        pokemonController?.fetchImage(from: pokemonImageUrl, completion: { pokemonImage in
            DispatchQueue.main.async {
                self.imageView.image = pokemonImage
            }
        })
    }
}
