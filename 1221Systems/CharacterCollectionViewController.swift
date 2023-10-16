//
//  CharacterCollectionViewController.swift
//  1221Systems
//
//  Created by Nurgali on 17.08.2023.
//

import UIKit

private enum Constants {
    static let collectionViewInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    static let collectionViewMinimumInteritemSpacing: CGFloat = 16
    static let collectionViewMinimumLineSpacing: CGFloat = 16
    static let totalColumns: CGFloat = 2
    static let heightRatio: CGFloat = 1.29
}

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
        layout.minimumInteritemSpacing = Constants.collectionViewMinimumInteritemSpacing
        
        // Set spacing between cells
        layout.minimumLineSpacing = Constants.collectionViewMinimumLineSpacing
        
        layout.sectionInset = Constants.collectionViewInsets
        
        // Calculate cell width based on the available space
        let totalSpacingBetweenColumns: CGFloat = layout.minimumInteritemSpacing * CGFloat(Constants.totalColumns - 1)
        let totalMargins: CGFloat = layout.sectionInset.left + layout.sectionInset.right
        let availableWidth = collectionView.bounds.width - totalSpacingBetweenColumns - totalMargins
        let cellWidth = availableWidth / Constants.totalColumns
        
        // Set cell size
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth * Constants.heightRatio)
        
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

// MARK: - UICollectionViewDelegate

extension CharacterCollectionViewController {

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let character = listOfCharacters[indexPath.item]
        let detailsViewController = CharacterDetailsViewController(character: character)
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}
