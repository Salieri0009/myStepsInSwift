//
//  APODViewController.swift
//  NasaApi
//
//  Created by Maxim on 02/09/2020.
//  Copyright © 2020 Maxim. All rights reserved.
//

import UIKit

protocol APODDisplayLogic: class {
    
    //отображение данных
    func displayAPODData(_ viewModel: APODModels.FetchAPOD.ViewModel)
}

class APODViewController: UIViewController {

    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var explanationLabel: UILabel!
    @IBOutlet var image: UIImageView!
    @IBOutlet var scrollView: UIScrollView!
    
    var interactor: APODBusnessLogic?
    let network = Network()
    
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
        fetchApodData()
        view.backgroundColor = .gray
        scrollView.backgroundColor = .black
        scrollView.layer.cornerRadius = 8
    }

    private func setup() {
        let interactor = ApodInteractor()
        let presenter = ApodPresenter()
        
        interactor.presenter = presenter
        presenter.viewController = self
        
        self.interactor = interactor
    }
    
    private func loadApodInformation() {
        let request = APODModels.FetchAPOD.Request()
        
        interactor?.fetchApodData(request)
    }
    
    private func fetchApodData(){
        loadApodInformation()
    }
}

extension APODViewController: APODDisplayLogic {
    func displayAPODData(_ viewModel: APODModels.FetchAPOD.ViewModel) {
        print(viewModel)
        dateLabel.text = viewModel.date
        dateLabel.textColor = .white
        titleLabel.text = viewModel.title
        titleLabel.textColor = .white
        explanationLabel.text = viewModel.explanation
        explanationLabel.textColor = .white
        network.loadImg(url: viewModel.url, completion: {
            [weak self] result in
            switch result{
            case .failure(let error):
                print(error)
            case .success(let img):
                DispatchQueue.main.async {
                    self?.image.image = img
                }
            }
        })
    }
}
