import Foundation

final class CharacterDetailsViewModel {
    
    // MARK: - Internal properties
    
    private let dispatchGroup = DispatchGroup()
    
    // MARK: - DI
    
    let character: Characters
    
    init(character: Characters) {
        self.character = character
    }
    
    func fetchEpisodes(completion: @escaping ([Episode]) -> Void) {
        
        var episodes: [Episode] = []
        
        for episode in character.episode {
            
            guard let episodeURL = URL(string: episode) else { continue }
            
            dispatchGroup.enter()
            
            URLSession.shared.dataTask(with: episodeURL) { [weak self] data, response, error in
                
                self?.dispatchGroup.leave()
                
                guard let data,
                      let decodedData = try? JSONDecoder().decode(Episode.self, from: data) else { return }
                
                episodes.append(decodedData)
            }.resume()
        }
        
        dispatchGroup.notify(queue: .main) {
            completion(episodes)
        }
    }
}
