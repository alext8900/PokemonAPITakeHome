//
//  Pokemon.swift
//  PokemonAPI
//
//  Created by Alex Thompson on 4/17/21.
//

import Foundation
import UIKit

struct Pokemon: Codable, Equatable {
    let name: String
    let id: Int
    let base_experience: Int
    let sprites: SpriteFront
    
    struct SpriteFront: Codable, Equatable {
        let imageUrl: String
    }
}
