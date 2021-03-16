//
//  AbstractNetwork.swift
//  pokeAPI
//
//  Created by Maxim on 09/07/2020.
//  Copyright © 2020 Maxim. All rights reserved.
//

import Foundation
import UIKit

protocol BaseNetworkProtocol {
    func request(with requestURL: URL, completion: @escaping((Result<Data, Error>) -> Void)) -> URLRequest?
}

protocol PokeNetworkProtocol {
    func getNumberOfPokemon(numbeOfPokemon: Int, fromNumber: Int, complition: @escaping((Result<PokeArray, Error>) -> Void))
    func getSinglePokemon(_ pokeName: String, complition: @escaping((Result<PokeData, Error>) -> Void))
    func loadImageFromUrl(_ url: URL, complitionInMain: @escaping((_ imageData: UIImage?) -> Void))
    func getDataFromURL<T:Decodable>(url: URL, type: T.Type, completion: @escaping((Result<T, Error>) -> Void))
}

final class AbstractNetwork: BaseNetworkProtocol {
    @discardableResult
    func request(with requestURL: URL, completion: @escaping ((Result<Data, Error>) -> Void)) -> URLRequest? {
        let task = URLSession.shared.dataTask(with: requestURL) {
            (data, response, error) in
                if let error = error {
                    print(error)
                    completion(.failure(error))
                    return
                }
                
            if let data = data{
                completion(.success(data))
            }
        }
        task.resume()
        return task.currentRequest
    }
}

class NetworkBrige {
    private let network = AbstractNetwork()
    private var getPokemon = "https://pokeapi.co/api/v2/pokemon"
}

extension NetworkBrige: PokeNetworkProtocol {
    func getDataFromURL<T>(url: URL, type: T.Type, completion: @escaping ((Result<T, Error>) -> Void)) where T : Decodable {
        network.request(with: url, completion: { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                let json = try? JSONDecoder().decode(T.self, from: data)
                if let jsonDecod = json {
                    completion(.success(jsonDecod))
                }
            }
        })
    }
    
    func getSinglePokemon(_ pokeName: String, complition: @escaping ((Result<PokeData, Error>) -> Void)) {
        guard let url = URL(string: getPokemon + "/" + pokeName + "/") else { return}
        network.request(with: url, completion: { result in
            switch result {
            case .failure(let error):
                complition(.failure(error))
            case .success(let data):
                let json = try? JSONDecoder().decode(PokeData.self, from: data)
                if let dataPokemon = json {
                    complition(.success(dataPokemon))
                }
            }
        })
    }
    
    func getNumberOfPokemon(numbeOfPokemon: Int, fromNumber: Int, complition: @escaping ((Result<PokeArray, Error>) -> Void)) {
        guard let url = URL(string: getPokemon + "?limit=" + String(numbeOfPokemon) + "&offset=" + String(fromNumber) ) else { return}
        network.request(with: url, completion: { result in
            switch result {
            case .failure(let error):
                complition(.failure(error))
            case .success(let data):
                let json = try? JSONDecoder().decode(PokeArray.self, from: data)
                if let pokemons = json {
                    complition(.success(pokemons))
                }
            }
        })
    }
    
    func loadImageFromUrl(_ url: URL, complitionInMain: @escaping ((UIImage?) -> Void)) {
        network.request(with: url, completion: { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let data):
                DispatchQueue.main.async {
                    let img = UIImage(data: data)
                    complitionInMain(img)
                }
            }
        })
    }
}
