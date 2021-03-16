//
//  NetworkRouter.swift
//  pokeAPI
//
//  Created by Maxim on 25/06/2020.
//  Copyright © 2020 Maxim. All rights reserved.
//

import Foundation
import UIKit

class NetworkRouter {
    let network: PokeNetworkProtocol = NetworkBrige()
    
    func getNumberOfPokemon(number: Int, fromNumber: Int, complition: @escaping((PokeArray) -> Void)){
        network.getNumberOfPokemon(numbeOfPokemon: number, fromNumber: fromNumber, complition: {
        result in
        switch result {
        case .failure(let error):
            print(error.localizedDescription)
        case .success(let pokeArray):
            print(pokeArray)
            DispatchQueue.main.async {
                complition(pokeArray)
            }
            }
        })
    }
    
    func getDataFromURL<T:Decodable>(url: URL, type: T.Type, completion: @escaping((T) -> Void)){
        network.getDataFromURL(url: url, type: T.self, completion: {
            result in
            switch result {
                case .failure(let error):
                    print(error)
                case .success(let data):
                    DispatchQueue.main.async {
                        completion(data)
                }
            }
        })
    }
    
    func loadImageFromUrl(_ url: URL, complitionInMain: @escaping((_ imageData: UIImage?) -> Void)){
        network.loadImageFromUrl(url, complitionInMain: complitionInMain)
    }
}
