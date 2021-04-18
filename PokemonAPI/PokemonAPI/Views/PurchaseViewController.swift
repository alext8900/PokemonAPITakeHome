//
//  PurchaseViewController.swift
//  PokemonAPI
//
//  Created by Alex Thompson on 4/18/21.
//

import UIKit

class PurchaseViewController: UIViewController {
    
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
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var completePurchase: UIButton!
    @IBOutlet var userName: UILabel!
    @IBOutlet var userEmail: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        // Do any additional setup after loading the view.
        completePurchase.layer.cornerRadius = 10
    }
    
    func updateViews() {
        guard isViewLoaded else { return }
        guard let pokemonObject = pokemon else { return }
        
        nameLabel.text = pokemonObject.name.capitalized
        priceLabel.text = "$\(Double(pokemonObject.base_experience * 6) * 0.01)"
        userName.text = "\(user.name) \(user.last)"
        userEmail.text = user.email
    }
}
