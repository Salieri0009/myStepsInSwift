//
//  ViewDataBaseController.swift
//  pokeAPI
//
//  Created by Maxim on 08/06/2020.
//  Copyright © 2020 Maxim. All rights reserved.
//

import UIKit

class ViewDataBaseController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var pokeDataArray = [PokeData]()
    let pokeCell = PokemonCellName()
    let pokeSegue = PokemonSegue()
    var loadedDataFromBase = [PokeData]()
    let realm = RealmWork()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView = UIView()
        loadedDataFromBase = realm.getLoadData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == pokeSegue.fromDataCell {
            if let vc = segue.destination as? ViewPokemonInforController {
                let pData = sender as? PokeData
                print(pData ?? "")
                vc.pokeData = pData
            }
        }
    }
}

extension ViewDataBaseController: UpdaterViewDataBaseController {
    func updateData(){
        loadedDataFromBase = realm.getLoadData()
        tableView.reloadData()
    }
}

extension ViewDataBaseController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loadedDataFromBase.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = loadedDataFromBase[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: pokeCell.pokDataBaseCell) as? TableViewDataBaseCell {
            cell.pokeCell = item
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let item = loadedDataFromBase[indexPath.row]
        
        let contextItem = UIContextualAction(style: .destructive, title: "Delete") {  (contextualAction, view, boolValue) in
            self.realm.deleteInData(item: item)
            self.updateData()
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])

        return swipeActions
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = loadedDataFromBase[indexPath.row]
        performSegue(withIdentifier: pokeSegue.fromDataCell, sender: item)
    }
}
