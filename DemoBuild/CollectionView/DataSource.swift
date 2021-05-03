//
//  CollectionView.swift
//  DemoBuild
//
//  Created by Andy Geipel on 5/2/21.
//

import UIKit

protocol CollectionViewSendingDelegate {
    func sendToPokemonVC(_ controller : DataSource, selectedPokemon : Pokemon)
}

class DataSource: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    // MARK: - Delegate
    
    var delegate : CollectionViewSendingDelegate? = nil
    
    // MARK: - Properties
    
    var pokemons = [Pokemon]()
    
    // MARK: - CollectionView
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pokemons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokemanCell", for: indexPath as IndexPath) as! PokemanCell
        
        cell.pokemanNameLbl.text = pokemons[indexPath.row].name?.capitalized
        let number = String(pokemons[indexPath.row].order!)
        cell.pokemanNumberLbl.text = number
        // Fetch image from URL
        if let imageUrlString = pokemons[indexPath.row].sprites.front_default  {
            let imageUrl:NSURL = NSURL(string: imageUrlString)!
            let imageData:NSData = NSData(contentsOf: imageUrl as URL)!
            
            DispatchQueue.main.async {
                let image = UIImage(data: imageData as Data)
                cell.pokemanImageView.image = image
            }
        }
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let noOfCellsInRow = 3
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedPokemon = pokemons[indexPath.row]
        self.delegate?.sendToPokemonVC(self, selectedPokemon: selectedPokemon)
    }
}
