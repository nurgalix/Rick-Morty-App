//
//  CharacterManager.swift
//  1221Systems
//
//  Created by Nurgali on 18.08.2023.
//

import Foundation

protocol CharacterManagerDelegate {
    func didFetchCharacter(_ characters: [Characters])
    func didFailWithError(_ error: Error)
}

struct CharacterManager {
    private let characterURLString = "https://rickandmortyapi.com/api/character"
    private let locationURLString = "https://rickandmortyapi.com/api/location"
    private let episodesURLString = "https://rickandmortyapi.com/api/episode"
    
    var delegate: CharacterManagerDelegate?
    
    func performRequest() {
        guard let url = URL(string: characterURLString) else {
            // TODO: Make throwable
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            print(error)
            // TODO: Handle error
            
            if let data,
               let characters = self.parseJSON(from: data) {
                DispatchQueue.main.async {
                    self.delegate?.didFetchCharacter(characters)
                }
            }
        }.resume()
    }
    
    func parseJSON(from characterData: Data) -> [Characters]? {
        let decoder = JSONDecoder()
        do {
            let characterResponse = try decoder.decode(CharacterResponse.self, from: characterData)
            let characters = characterResponse.results
            return characters
        } catch {
            // TODO: Handle error properly
            print(error)
            return nil
        }
    }
}
