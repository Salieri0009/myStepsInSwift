//
//  NeoWSViewController.swift
//  NasaApi
//
//  Created by Maxim on 02/09/2020.
//  Copyright © 2020 Maxim. All rights reserved.
//

import UIKit

protocol NeoWSDisplayLogic: class {
    
    //отображение данных
    func displayNeoWSCellData(_ neoWSCell: NeoWSModel.FetchNeoWS.ViewModelDay)
    
    func displayNeoWSIdData(_ neoWSSingle: NeoWSModel.FetchNeoWS.ViewModelID)
}

class NeoWSViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    private var presentData = [NearEarthObjects]()
    private var links = Links(next: nil, prev: nil, self: "")
    
    var interactor: NeoWSBusnessLogic?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "NeoWSTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "NeoWSTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        fetchNeoWSData()
        tableView.backgroundColor = .gray
        view.backgroundColor = .gray
        // Do any additional setup after loading the view.
    }
    
    private func setup() {
        let interactor = NeoWSInteractor()
        let presenter = NeoWSPresenter()
        
        interactor.presenter = presenter
        presenter.viewController = self
        
        self.interactor = interactor
    }

    private func loadNeoWSInformation() {
        let request = NeoWSModel.FetchNeoWS.RequestDates(startData: "2015-09-07", endData: "2015-09-08")
            
        interactor?.fetchNeoWSDataFromDates(request)
    }
        
    private func fetchNeoWSData() {
        loadNeoWSInformation()
    }
//    MARK: функция для подгрузки данных
    private func pading() {
        if let nextLink = links.next{
            let request = NeoWSModel.FetchNeoWS.RequestUrl(url: nextLink)
            interactor?.fetchNeoWSdataFromUrl(request)
        }
    }
}

extension NeoWSViewController: NeoWSDisplayLogic{
    func displayNeoWSCellData(_ neoWSCell: NeoWSModel.FetchNeoWS.ViewModelDay) {
        for item in neoWSCell.data.near_earth_objects.values {
            presentData += item
        }
        links = neoWSCell.data.links
        tableView.reloadData()
    }
    
    func displayNeoWSIdData(_ neoWSSingle: NeoWSModel.FetchNeoWS.ViewModelID) {
        
    }
}

extension NeoWSViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presentData.count + 1
    }
//      MARK: Решил добавить статус бар в конец таблицы
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == self.presentData.count{
            let cell = tableView.dequeueReusableCell(withIdentifier: "loadCell", for: indexPath)
            cell.backgroundColor = .black
            cell.layer.cornerRadius = 4
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NeoWSTableViewCell") as! NeoWSTableViewCell
        cell.setTextInCell(someData: presentData[indexPath.row])
        return cell
    }
// MARK:  Как доходим до предпоследней записи в данных начинаем подгружать следующие
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == presentData.count - 1 {
            pading()
        }
    }
}
