//
//  PokemonController.swift
//  PokemonAPI
//
//  Created by Alex Thompson on 4/17/21.
//

import Foundation
import UIKit

let pokemonPurchaseViewController = PokemonPurchaseViewController()
enum HTTPMethod: String {
    case get = "GET"
}

enum NetworkError: Error {
    case otherError
    case badData
    case noDecode
    case noError
}

class PokemonController {
    var pokemonList: [Pokemon] = []
    var pokemonImages: [URL] = []
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")
    func fetchPokemon(pokemonName: String, completion: @escaping ((Result<Pokemon, Error>) -> Void)) {
        let requestURL = baseURL?.appendingPathComponent(pokemonName.lowercased())
        guard let url = requestURL else { return }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data returned: \(error?.localizedDescription)")
                return
            }
            
            do {
                let pokemonSearch = try JSONDecoder().decode(Pokemon.self, from: data)
                completion(.success(pokemonSearch))
            } catch {
                print("Unable to decode data into object of type [Pokemon]: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchImage(from imageURL: String, completion: @escaping(UIImage?) -> Void) {
        guard let imageURL = URL(string: imageURL) else {
            completion(nil)
            return }
        
        var request = URLRequest(url: imageURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { imageData, _, error in
            if let error = error {
                print("Error fetching image: \(error.localizedDescription)")
                return
            }
            
            guard let data = imageData else {
                print("No data provided for image: \(imageURL)")
                completion(nil)
                return
            }
            
            let image = UIImage(data: data)
            
            completion(image)
        }.resume()
    }
    
    func addPokemon(pokemon: Pokemon) {
        pokemonList.append(pokemon)
    }
}
