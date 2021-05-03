//
//  PokemonVC.swift
//  DemoBuild
//
//  Created by Andy Geipel on 4/30/21.
//

import UIKit

class PokemonVC: UIViewController, PokemonSendingDelegate, CollectionViewSendingDelegate {
    
    //MARK:- Properties
    
    private let dataManager = DataManager()
    private let dataSource = DataSource()
    
    private var pokemons = [Pokemon]()
    
    //MARK:- IBOutlet
    
    @IBOutlet private var collectionView: UICollectionView!
    
    //MARK:- Lifecycle
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupNavigationControllerAttributes()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
        setupDataSources()
    }
    
    //MARK:- Private
    
    private func setupDelegates() {
        dataManager.delegate = self
        dataSource.delegate = self
    }
    
    private func setupDataSources() {
        collectionView.dataSource = dataSource
        collectionView.delegate = dataSource
    }
    
    private func setupNavigationControllerAttributes() {
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: Constants().pokemonFont, size: 30)!]
        navigationController?.navigationBar.topItem?.title = "Pokeman"
    }
    
    //MARK:- Delegate Methods
    
    // Receive Pokemon model from CollectionView and pass to DetailVC
    func sendToPokemonVC(_ controller: DataSource, selectedPokemon: Pokemon) {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailVC") as? DetailVC {
            viewController.pokemon = selectedPokemon
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }

    // Receive Pokemon DataManager
    func sendToPokemonVC(thisData: Pokemon) {
        dataSource.pokemons.append(thisData)
        collectionView.reloadData()
    }
}
