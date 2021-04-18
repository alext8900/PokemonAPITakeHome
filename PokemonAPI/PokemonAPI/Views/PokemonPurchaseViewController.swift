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
    
    var user = User()
    
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

    // MARK: UPDATE VIEWS
    
    func updateViews() {
        guard isViewLoaded else { return }
        guard let pokemonObject = pokemon else {
            title = "Pokemon Search"
            buyButton.backgroundColor = UIColor.gray
            
            return }
        buyButton.isEnabled = true
        title = pokemonObject.name.capitalized
        priceLabel.text = "$\(Double(pokemonObject.base_experience * 6) * 0.01)"
        
        
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
        }
    }
}

extension PokemonPurchaseViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        hideKeyboard()
        buyButton.isEnabled = true
        buyButton.backgroundColor = UIColor.systemBlue
        guard let searchTerm = searchBar.text else { return }
        
        pokemonController?.fetchPokemon(pokemonName: searchTerm, completion: { pokemonObject in
            guard let pokemon = try? pokemonObject.get() else { return }

            DispatchQueue.main.async {
                self.pokemon = pokemon
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
