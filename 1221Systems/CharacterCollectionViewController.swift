//
//  CharacterCollectionViewController.swift
//  1221Systems
//
//  Created by Nurgali on 17.08.2023.
//

import UIKit


class CharacterCollectionViewController: UICollectionViewController {

    private var characterManager = CharacterManager()
    private var listOfCharacters: [Characters] = []
    let dataSource: [String] = ["Rick", "Morty", "Summer"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        characterManager.delegate = self
        characterManager.performRequest()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOfCharacters.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()

        if let characterCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CharacterCollectionViewCell {
            characterCell.configure(with: listOfCharacters[indexPath.row].name, image: listOfCharacters[indexPath.row].image)
            
            cell = characterCell
        }
        
        return cell
    }
}

extension CharacterCollectionViewController: CharacterManagerDelegate {
    func didFetchCharacter(_ characters: [Characters]) {
        self.listOfCharacters = characters
        collectionView.reloadData()
    }
    
    func didFailWithError(_ error: Error) {
        print(error)
    }
    
    
}
