//
//  DataManager.swift
//  DemoBuild
//
//  Created by Andy Geipel on 5/1/21.
//

import Foundation

protocol PokemonSendingDelegate {
    func sendToPokemonVC(thisData: Pokemon)
}

class DataManager {
    
    // MARK: - Delegate
    
    var delegate: PokemonSendingDelegate? = nil

    // MARK: - Init
    
    init() {
        loadJSON()
    }
    
    // MARK: - Public
    
    func loadJSON() {
        let url = Constants().pokemonURL
        // 1. Get object
        guard let urlObj = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: urlObj) {(data, response, error) in
            guard let data = data else { return }
            
            do {
                // 2. Decode JSON
                let pokedex = try JSONDecoder().decode(Pokedex.self, from: data)
                // 3. Iterate through decoded Pokemon results
                for pokemon in pokedex.results {
                    guard let jsonURL = pokemon.url else { return }
                    guard let newURL = URL(string: jsonURL) else { return }
                    // 4. Fetch data for each Pokemon via it's URL
                    URLSession.shared.dataTask(with: newURL) {(data, response, error) in
                        guard let data = data else { return }
                        
                        do {
                            // 5. Decode JSON
                            let load = try JSONDecoder().decode(Pokemon.self, from: data)
                            DispatchQueue.main.async {
                                // 6. Send data to delegate (PokemonVC) via protocol
                                self.delegate?.sendToPokemonVC(thisData: load)
                            }
                        } catch let jsonErr {
                            print("Error serializing inner JSON:", jsonErr)
                        }
                    }.resume()
                }
            } catch let jsonErr{
                print("Error serializing JSON: ", jsonErr)
            }
        }.resume()
    }
}
