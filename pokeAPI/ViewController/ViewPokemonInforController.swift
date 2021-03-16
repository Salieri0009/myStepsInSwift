//
//  ViewPokemonInforController.swift
//  pokeAPI
//
//  Created by Maxim on 10/06/2020.
//  Copyright © 2020 Maxim. All rights reserved.
//

import UIKit

protocol UpdaterViewDataBaseController: class {
    func updateData()
}

class ViewPokemonInforController: UIViewController {
    
    @IBOutlet weak var hpStat: UILabel!
    @IBOutlet weak var hpNum: UILabel!
    @IBOutlet weak var attackStat: UILabel!
    @IBOutlet weak var attackNum: UILabel!
    @IBOutlet weak var defenseStat: UILabel!
    @IBOutlet weak var defenseNum: UILabel!
    @IBOutlet weak var specialAttackStats: UILabel!
    @IBOutlet weak var specialAttackNum: UILabel!
    @IBOutlet weak var specialDefStats: UILabel!
    @IBOutlet weak var specialDefNum: UILabel!
    @IBOutlet weak var speedStat: UILabel!
    @IBOutlet weak var speedNum: UILabel!
    @IBOutlet weak var inforLabel: UILabel!
    @IBOutlet weak var imageScrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var addButton: UIButton!
    
    var pokeData: PokeData? {
        didSet {
            self.title = pokeData?.name?.capitalized
        }
    }
    
    private var imageArray = [UIImage?]()
    private let networkRouter = NetworkRouter()
    private var i = 0
    private let pokeSegue = PokemonSegue()
    private let realm = RealmWork()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadInfor()
        pageControl.numberOfPages = imageArray.count
        loadImages()
        setStatInfor()
        // Do any additional setup after loading the view.
    }
    @IBAction func addPokemon(_ sender: UIButton) {
        realm.write(pData: pokeData)
        findItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        findItem()
    }
}

private extension ViewPokemonInforController {
    func findItem() {
        if let pokeData = pokeData{
            if realm.isInWriteData(pData: pokeData) {
                addButton.setTitle("Added", for: .normal)
                return
            }
        }
        addButton.setTitle("Add", for: .normal)
    }
    
    func setStatInfor() {
        hpStat.text = pokeData?.stats[0].stat.name.capitalized
        hpNum.text = String(describing: pokeData?.stats[0].base_stat ?? 0)
        
        attackStat.text = pokeData?.stats[1].stat.name.capitalized
        attackNum.text = String(describing: pokeData?.stats[1].base_stat ?? 0)
        
        defenseStat.text = pokeData?.stats[2].stat.name.capitalized
        defenseNum.text = String(describing: pokeData?.stats[2].base_stat ?? 0)
        
        specialAttackStats.text = pokeData?.stats[3].stat.name.capitalized
        specialAttackNum.text = String(describing: pokeData?.stats[3].base_stat ?? 0)
        
        specialDefStats.text = pokeData?.stats[4].stat.name.capitalized
        specialDefNum.text = String(describing: pokeData?.stats[4].base_stat ?? 0)
        
        speedStat.text = pokeData?.stats[5].stat.name.capitalized
        speedNum.text = String(describing: pokeData?.stats[5].base_stat ?? 0)
    }
    
    func loadImages() {
        if let sprites = pokeData?.sprites {
        for case let (label?, value) in Mirror(reflecting: sprites).children.map( {
            ($0.label, $0.value)}) {
                if let str = value as? String {
                    if let url = URL(string: str) {
                        networkRouter.loadImageFromUrl(url, complitionInMain: {
                            [weak self] img in
                            self?.appedImages(img: img, title: label)
                        })
                    }
                }
            }
        }
    }
    
    func setImages() {
        var j = 0
        for img in imageArray {
            let imageView = UIImageView()
            imageView.contentMode = .scaleToFill
            imageView.image = img
            
            let xPos = CGFloat(j) * self.view.bounds.size.width
            imageView.frame = CGRect(x: xPos, y: 0, width: view.frame.size.width, height: imageScrollView.frame.size.height)
            imageScrollView.contentSize.width = view.frame.size.width * CGFloat(j + 1)
            j += 1
            imageScrollView.addSubview(imageView)
        }
    }
    
    func appedImages(img: UIImage?, title: String?) {
        let freeSpace: CGFloat = 20
        imageArray.append(img)
        
        let label = UILabel()
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image = img
        
        let xPos = CGFloat(i) * self.view.bounds.size.width
        imageView.frame = CGRect(x: xPos, y: 0, width: view.frame.size.width, height: imageScrollView.frame.size.height)
        imageScrollView.contentSize.width = view.frame.size.width * CGFloat(i + 1)
        label.text = title?.capitalized.replacingOccurrences(of: "_", with: " ")
        label.frame = CGRect(x: xPos + freeSpace, y: 0, width: view.frame.size.width, height: freeSpace)
            
        i += 1
        imageScrollView.addSubview(imageView)
        imageScrollView.addSubview(label)
        pageControl.numberOfPages = imageArray.count
        imageScrollView.reloadInputViews()
    }
    
    func loadInfor() {
        var str = ""
        
        if let urlString = pokeData?.location_area_encounters {
            if let url = URL(string: urlString) {
                networkRouter.getDataFromURL(url: url, type: [PokeLocation].self, completion: {
                    [weak self] data in
                    DispatchQueue.main.async {
                        if let parseStr = self?.parseInforData(inforData: data){
                            str += parseStr
                            str += "\n"
                            self?.inforLabel.text = str
                        }
                    }
                })
            }
        }
        
        if let types = pokeData?.types {
            var type = "Type:"
            for t in types {
                if let nameType = t.type?.name {
                    type += " " + nameType
                }
            }
            str += type + "\n"
        }
    }
    
    func parseInforData(inforData: [PokeLocation]) -> String {
        var str = ""
        for elem in inforData {
            if let lokArea = elem.location_area?.name {
                str += "Location area: " + lokArea.replacingOccurrences(of: "-", with: " ") + " in game"
                for version in elem.version_details {
                    str += " Pokemon " + version.version.name
                }
                str += "\n"
            }
        }
        return str
    }
}

extension ViewPokemonInforController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.frame.width
        pageControl.currentPage = Int(page)
    }
    
}
