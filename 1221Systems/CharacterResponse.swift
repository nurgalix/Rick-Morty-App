//
//  CharacterResponse.swift
//  1221Systems
//
//  Created by Nurgali on 18.08.2023.
//

import Foundation


// MARK: - CharacterResponse
struct CharacterResponse: Codable {
    let results: [Characters]
}

// MARK: - Result
struct Characters: Codable {
    let id: Int
    let name: String
    let status: Status
    let species: Species
    let type: String
    let gender: Gender
    let origin, location: Location
    let image: String
    let episode: [String]
}

extension Characters {
    static var mockCharacter: Characters {
        .init(id: 5, name: "ASD", status: .alive, species: .alien, type: "ASD", gender: .female, origin: .init(name: "asd", url: "https://rickandmortyapi.com/api/location/1"), location: .init(name: "asd", url: "https://rickandmortyapi.com/api/location/3"), image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg", episode: [
            "https://rickandmortyapi.com/api/episode/1",
            "https://rickandmortyapi.com/api/episode/2",
            "https://rickandmortyapi.com/api/episode/3",
            "https://rickandmortyapi.com/api/episode/4",
            "https://rickandmortyapi.com/api/episode/5",
            "https://rickandmortyapi.com/api/episode/6",
            "https://rickandmortyapi.com/api/episode/7",
            "https://rickandmortyapi.com/api/episode/8",
            "https://rickandmortyapi.com/api/episode/9",
            "https://rickandmortyapi.com/api/episode/10"])
    }
}

enum Gender: String, Codable {
    case female = "Female"
    case male = "Male"
    case unknown = "unknown"
}

// MARK: - Location
struct Location: Codable {
    let name: String
    let url: String
}

enum Species: String, Codable {
    case alien = "Alien"
    case human = "Human"
}

enum Status: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}


// MARK: - CharacterResponse

struct CharacterDetailResponse: Codable {
    let id: Int
    let name, type, dimension: String
    let residents: [String]
    let url: String
    let created: String
}
