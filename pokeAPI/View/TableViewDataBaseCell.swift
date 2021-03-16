//
//  TableViewDataBaseCell.swift
//  pokeAPI
//
//  Created by Maxim on 08/06/2020.
//  Copyright © 2020 Maxim. All rights reserved.
//

import UIKit

class TableViewDataBaseCell: UITableViewCell {
    
    @IBOutlet weak var imageViewCell: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    let network = NetworkRouter()
    
    var pokeCell: PokeData? {
        didSet {
            titleLabel.text = pokeCell?.name?.capitalized
            imageURL = URL(string: (pokeCell?.sprites.front_default)!)
        }
    }
    
    private var imageURL: URL? {
        didSet {
            imageView?.image = nil
            updateImage()
        }
    }
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func senteredAnimation() {
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    func updateImage() {
        
        if let url = imageURL {
            spinner.startAnimating()
            imageViewCell.addSubview(spinner)
            senteredAnimation()
            network.loadImageFromUrl(url, complitionInMain: {
                [weak self] image in
                
                if url == self?.imageURL{
                    self?.imageViewCell.image = image
                    self?.spinner.stopAnimating()
                    self?.spinner.removeFromSuperview()
                }
            })
        }
    }
    
    
}
