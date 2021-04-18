//
//  PokemonCollectionViewController.swift
//  PokemonAPI
//
//  Created by Alex Thompson on 4/17/21.
//

import UIKit

private let reuseIdentifier = "PokemonCell"


class PokemonCollectionViewController: UICollectionViewController {
    
    // MARK: - PROPERTIES
    
    let pokemonController = PokemonController()
    
    var pokemon: Pokemon! {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemonController.pokemonList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PokemonCollectionViewCell
        let pokemonMonster = pokemonController.pokemonList[indexPath.item]
        cell.nameLabel.text = pokemonMonster.name
        
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelectSegue" {
            guard let pokemonVC = segue.destination as? PokemonPurchaseViewController,
                  let indexPath = collectionView.indexPathsForSelectedItems?.first else { return }
            pokemonVC.pokemonController = pokemonController
            pokemonVC.pokemon = pokemonController.pokemonList[indexPath.item]
            
        } else if segue.identifier == "SearchSegue" {
            if let searchVC = segue.destination as? PokemonPurchaseViewController {
                searchVC.pokemonController = pokemonController
            }
        }
    }
}
