//
//  DetailVC.swift
//  DemoBuild
//
//  Created by Andy Geipel on 5/1/21.
//

import UIKit

class DetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK:- Properties
    
    public var pokemon: Pokemon?
    
    // MARK:- IBOutlets
    
    @IBOutlet private var pokemanImageView: UIImageView!
    @IBOutlet private var pokemanNameLbl: UILabel!
    @IBOutlet private var pokemanWeightLbl: UILabel!
    @IBOutlet private var pokemanExperienceLbl: UILabel!
    @IBOutlet private var tableView: UITableView!
    
    // MARK:- Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationTitle()
        updatePokemanInfo()
        setupTableViewCorners()
    }

    // MARK:- Private
    
    private func fetchImage() {
        if let imageUrlString = pokemon!.sprites.front_default  {
            let imageUrl:NSURL = NSURL(string: imageUrlString)!
            let imageData:NSData = NSData(contentsOf: imageUrl as URL)!
            
            DispatchQueue.main.async {
                let image = UIImage(data: imageData as Data)
                self.pokemanImageView.image = image
            }
        }
    }
    
    private func updatePokemanInfo() {
        fetchImage()
        
        guard let thisPokemon = pokemon else {return}
        
        guard let pokemonName = thisPokemon.name else {return}
        pokemanNameLbl.text = "Name: \(pokemonName.capitalized)"
        
        guard let pokemonWeight = thisPokemon.weight else {return}
        pokemanWeightLbl.text = "Weight: \(String(describing: pokemonWeight))"
        
        guard let pokemonExperience = thisPokemon.base_experience else {return}
        pokemanExperienceLbl.text = "Experience: \(String(describing: pokemonExperience))xp"
    }
    
    // MARK:- UI Customization
    private func setNavigationTitle() {
        guard let thisPokemon = pokemon else {return}
        guard let pokemonName = thisPokemon.name else {return}
        self.title = "\(pokemonName.capitalized) Details"
            navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .white
    }

    private func setupTableViewCorners() {
        self.tableView.layer.cornerRadius = 10.0
    }
}

    // MARK:- TableView Methods

extension DetailVC {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemon!.moves.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovesCell", for: indexPath as IndexPath) as! MovesCell
        
        cell.nameLbl.text = pokemon!.moves[indexPath.row].move.name
        cell.levelLearnedLbl.text = "Learned at level  \(String(pokemon!.moves[indexPath.row].version_group_details[0].level_learned_at!))"
        
        return cell
    }
}
