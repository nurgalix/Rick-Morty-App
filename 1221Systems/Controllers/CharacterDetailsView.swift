import SwiftUI
//import SwiftLoader

struct CharacterDetailsView: View {
    private let character: Characters
    @State var data = CharacterDetailResponse(id: 1, name: "asd", type: "asd", dimension: "asd", residents: ["asd"], url: "asd", created: "ASD")
    
    @State var episodeData: [Episode] = []
    
    @State private var isLoading = true
    
    let viewModel: CharacterDetailsViewModel
    
    init(viewModel: CharacterDetailsViewModel) {
        self.viewModel = viewModel
        self.character = viewModel.character
    }
    
    func getEpisodeDetails() {
        for str in character.episode {
            guard let url = URL(string: str) else {
//                print("Invalid URL: \(str)")
                continue
            }
            URLSession.shared.dataTask(with: url) { data, response, error in
                DispatchQueue.main.async {
                    if let data = data {
                        do {
                            let decoder = JSONDecoder()
                            let decodedData = try decoder.decode(Episode.self, from: data)
                            self.episodeData.append(decodedData)
                        } catch {
//                            print("Error decoding data: \(error)")
                        }
                    }
                }
            }.resume()
        }
    }
    
    func getData() {
        let urlString = character.location.url
        let url = URL(string: urlString)
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let decodedData = try decoder.decode(CharacterDetailResponse.self, from: data)
                        self.data = decodedData
                    } catch {
//                        print("Error")
                    }
                }
            }
        }.resume()
    }
    
    var body: some View {
        Group {
            if isLoading {
                ProgressView()
            } else {
                ScrollView {
                    VStack(spacing: 8) {
                        AsyncImage(url: URL(string: character.image)) { image in
                            image
                                .resizable()
                        } placeholder: {
                        }
                        .scaledToFit()
                        .frame(maxWidth: 155, maxHeight: 155)
                        .clipped()
                        .cornerRadius(16)
                        
                        Text(character.name)
                            .foregroundColor(.white)
                            .frame(alignment: .center)
                            .font(.system(size: 22, weight: .bold))
                        
                        if character.status.rawValue == "Alive" {
                            Text("Alive")
                                .font(.system(size: 16))
                                .foregroundColor(.green)
                        } else if character.status.rawValue == "Dead" {
                            Text("Dead")
                                .font(.system(size: 16))
                                .foregroundColor(.red)
                        } else {
                            Text("unknown")
                                .font(.system(size: 16))
                                .foregroundColor(.gray)
                        }
                        
                        Text("Info")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size: 17, weight: .bold))
                            .padding()
                            .foregroundColor(.white)
                        
                        VStack(spacing: 8) {
                            HStack {
                                Text("Species:")
                                    .foregroundColor(.gray)
                                    .padding()
                                Spacer()
                                Text(character.gender.rawValue)
                                    .foregroundColor(.white)
                                    .padding()
                            }
                            
                            HStack {
                                Text("Type:")
                                    .foregroundColor(.gray)
                                    .padding()
                                Spacer()
                                if character.type == "" {
                                    style1Text(with: "None")
                                } else {
                                    style1Text(with: character.type)
                                }
                            }
                            
                            HStack {
                                Text("Gender")
                                    .foregroundColor(.gray)
                                    .padding()
                                Spacer()
                                Text(character.gender.rawValue)
                                    .foregroundColor(.white)
                                    .padding()
                            }
                        }
                        .background(Color.hex("262A38").edgesIgnoringSafeArea(.all))
                        .cornerRadius(16)
                        
                        Text("Origin")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size: 17, weight: .bold))
                            .padding()
                        HStack(spacing: 16) {
                            let _ = self.getData()
                            //                    let _ = self.getEpisodeDetails()
                            Image(systemName: "globe")
                                .resizable()
                                .frame(width: 24, height: 24, alignment: .leading)
                                .tint(.white)
                                .foregroundColor(.white)
                                .padding()
                            VStack {
                                Text(data.name)
                                    .foregroundColor(.white)
                                    .font(.system(size: 17, weight: .bold))
                                
                                Text(data.type)
                                    .font(.system(size: 13))
                                    .foregroundStyle(.green)
                                
                            }
                            Spacer()
                        }
                        .frame(width: .infinity, height: 80, alignment: .leading)
                        .background(Color.hex("262A38").edgesIgnoringSafeArea(.all))
                        .cornerRadius(16)
                        
                        Text("Episodes")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size: 17, weight: .bold))
                            .padding()
                        
                        Group {
                            
                            ForEach(episodeData, id: \.self) { ep in
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(ep.name)
                                        .foregroundColor(.white)
                                        .font(.system(size: 17, weight: .bold))
                                        .padding()
                                    HStack {
                                        Text(ep.episode)
                                            .foregroundColor(.green)
                                            .padding()
                                        Spacer()
                                        if ep.airDate != nil {
                                            Text(ep.airDate!)
                                                .foregroundColor(Color.hex("93989C"))
                                                .padding()
                                        } else {
                                            Text("Missing air-date")
                                                .foregroundColor(Color.hex("93989C"))
                                                .padding()
                                        }
                                    }
                                }
                            }
                        }
                        .background(Color.hex("262A38").edgesIgnoringSafeArea(.all))
                        .cornerRadius(16)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity) // 1
                .background(Color.hex("#040C1E"))
            }
        }
        .onAppear {
            self.viewModel.fetchEpisodes { episodes in
                self.episodeData = episodes
                self.isLoading = false
            }
        }
    }
    
    // MARK: - UI
    
    private func style1Text(with text: String) -> some View {
        Text(text)
            .foregroundColor(.white)
            .padding()
    }
}

//struct CharacterDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        CharacterDetailsView(character: .mockCharacter)
//    }
//}
