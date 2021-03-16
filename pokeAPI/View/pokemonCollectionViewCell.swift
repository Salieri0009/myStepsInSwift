//
//  pokemonCollectionViewCell.swift
//  pokeAPI
//
//  Created by Maxim on 08/06/2020.
//  Copyright © 2020 Maxim. All rights reserved.
//

import UIKit

class PokemonCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    let network = NetworkRouter()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    private var imageURL: URL? {
        didSet {
            imageView?.image = nil
            updateImage()
        }
    }
    
    var pokeCell: PokeData? {
        didSet {
            nameLabel.text = pokeCell?.name?.capitalized
            imageURL = URL(string: (pokeCell?.sprites.front_default)!)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

private extension PokemonCollectionViewCell {
    func senteredAnimation() {
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func updateImage() {
        if let url = imageURL {
            spinner.startAnimating()
            imageView?.addSubview(spinner)
            senteredAnimation()
            network.loadImageFromUrl(url, complitionInMain: {
                [weak self] image in
                
                if url == self?.imageURL{
                    self?.imageView?.image = image
                    self?.spinner.stopAnimating()
                    self?.spinner.removeFromSuperview()
                }
            })
        }
    }
}
