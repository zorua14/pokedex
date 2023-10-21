//
//  FetchController.swift
//  Pokedex
//
//  Created by Karthikeyan Muthu on 16/10/23.
//

import Foundation

struct FetchController{
    enum NetworkeError:Error{
        case badURL,badResponse,badData
    }
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    func fetchAllPokemon() async throws -> [TempPokemon] {
        var allPokemon: [TempPokemon] = []
        
        var fetchComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        fetchComponents?.queryItems = [URLQueryItem(name: "limit", value: "151")]
        
        guard let fetchURL = fetchComponents?.url else{
            throw NetworkeError.badURL
        }
        
        let (data,response) = try await URLSession.shared.data(from: fetchURL)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
            throw NetworkeError.badResponse
        }
        
        guard let pokeDictionary = try JSONSerialization.jsonObject(with: data) as? [String:Any], let pokedex = pokeDictionary["results"] as? [[String:String]] else{
            throw NetworkeError.badData
        }
        for i in pokedex{
            if let url = i["url"]{
                allPokemon.append(try await fetchPokemon(from: URL(string: url)!))
            }
        }
        return allPokemon
    }
    
    private func fetchPokemon(from url: URL) async throws -> TempPokemon {
        let (data,response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
            throw NetworkeError.badResponse
        }
         
        let tempPokemon = try JSONDecoder().decode(TempPokemon.self,from: data)
        
        return tempPokemon
    }
    
}
