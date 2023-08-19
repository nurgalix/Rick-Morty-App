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
        
        navigationItem.title = "Characters"
        
        characterManager.delegate = self
        characterManager.performRequest()
        
        // Initialize the collection view layout
        let layout = UICollectionViewFlowLayout()
        
        // Set spacing between columns
        layout.minimumInteritemSpacing = 8
        
        // Set spacing between cells
        layout.minimumLineSpacing = 16
        
        // Set left margin
        layout.sectionInset.left = 20
        
        // Set right margin
        layout.sectionInset.right = 27
        
        // Calculate cell width based on the available space
        let totalSpacingBetweenColumns: CGFloat = layout.minimumInteritemSpacing * CGFloat(2 - 1)
        let totalMargins: CGFloat = layout.sectionInset.left + layout.sectionInset.right
        let availableWidth = collectionView.bounds.width - totalSpacingBetweenColumns - totalMargins
        let cellWidth = availableWidth / 2
        
        // Set cell size
        layout.itemSize = CGSize(width: cellWidth, height: 202)
        
        // Assign the layout to the collection view
        collectionView.collectionViewLayout = layout
        
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
