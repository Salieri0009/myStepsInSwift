//
//  ViewController.swift
//  pokeAPI
//
//  Created by Maxim on 08/06/2020.
//  Copyright © 2020 Maxim. All rights reserved.
//

import UIKit

class ViewPokedexController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    let networkRouter = NetworkRouter()
    var dataArrayPokemon = PokeArray(results: [])
    var numberOfPokemon = 30
    var fromNumberOfPokemon = 0
    var isLoad = true
    
    let pokeSegue = PokemonSegue()
    let pokeCell = PokemonCellName()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate  = self
        loadPokeArray()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == pokeSegue.fromPokedex {
            if let vc = segue.destination as? ViewPokemonInforController {
                let pData = sender as? PokeData
                print(pData ?? "")
                vc.pokeData = pData
            }
        }
    }
}

extension ViewPokedexController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArrayPokemon.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = loadCell(cellForItemAt: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        loadSingleCell(cellForItemAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print(dataArrayPokemon.results[indexPath.row])
        if indexPath.row == dataArrayPokemon.results.count - 1 && isLoad {
            isLoad = false
            loadPokeArray()
        }
    }
}

extension ViewPokedexController {
    func loadSingleCell(cellForItemAt indexPath: IndexPath) {
        if let url = URL(string: dataArrayPokemon.results[indexPath.row].url){
            networkRouter.getDataFromURL(url: url, type: PokeData.self, completion: {
                [weak self] data in
                DispatchQueue.main.async {
                    if let fromPokedex = self?.pokeSegue.fromPokedex {
                        self?.performSegue(withIdentifier: fromPokedex, sender: data)
                    }
                }
            })
        }
    }
    
    func loadPokeArray() {
        networkRouter.getNumberOfPokemon(number: numberOfPokemon, fromNumber: fromNumberOfPokemon, complition: {
            [weak self] poAr in
            DispatchQueue.main.async {
                if let numberOfPokemon = self?.numberOfPokemon {
                    self?.dataArrayPokemon.results += poAr.results
                    self?.fromNumberOfPokemon += numberOfPokemon
                    self?.collectionView.reloadData()
                    self?.isLoad = true
                }
            }
        })
    }
    
    func loadCell(cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pokeCell.pokemonCell, for: indexPath) as? PokemonCollectionViewCell {
        if let url = URL(string: dataArrayPokemon.results[indexPath.row].url) {
            networkRouter.getDataFromURL(url: url, type: PokeData.self, completion: {
                data in
                    DispatchQueue.main.async {
                        cell.pokeCell = data
                    }
                })
            }
            return cell
        }
        return UICollectionViewCell()
    }
}
