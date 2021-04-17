//
//  PokemonPurchaseViewController.swift
//  PokemonAPI
//
//  Created by Alex Thompson on 4/17/21.
//

import UIKit

class PokemonPurchaseViewController: UIViewController {
    
    // MARK: - PROPERTIES
    // MARK: - OUTLETS
    
    @IBOutlet weak var buyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if buyButton.isEnabled == false {
            buyButton.backgroundColor = UIColor.gray
        }
        buyButton.layer.cornerRadius = 10

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
