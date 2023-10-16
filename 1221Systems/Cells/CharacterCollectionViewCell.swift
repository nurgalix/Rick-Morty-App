//
//  CharacterCollectionViewCell.swift
//  1221Systems
//
//  Created by Nurgali on 17.08.2023.
//

import UIKit

final class CharacterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet weak var characterImage: UIImageView!
    
    func configure(with name: String, image: String) {
        nameLabel.text = name
        if let url = URL(string: image) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                // Error handling...
                guard data != nil else { return }
                DispatchQueue.main.async {
                    self.characterImage.image = UIImage(data: data!)
                }
            }.resume()
        }
    }
}
