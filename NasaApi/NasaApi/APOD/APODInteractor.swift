//
//  File.swift
//  NasaApi
//
//  Created by Maxim on 02/09/2020.
//  Copyright © 2020 Maxim. All rights reserved.
//

import Foundation
import UIKit

protocol APODBusnessLogic: class {
    
    //отображение данных
    func fetchApodData(_ request: APODModels.FetchAPOD.Request)
}

class ApodInteractor: APODBusnessLogic {
    let network = Network()
    
    var presenter: APODPresentationLogic?
    
    func fetchApodData(_ request: APODModels.FetchAPOD.Request) {
        network.getApodData(completion: {
            [weak self] result in
            switch result {
                case .failure(let error):
                    print(error)
                case .success(let data):
                    DispatchQueue.main.async {
                        let response = APODModels.FetchAPOD.Response(date: data.date, explanation: data.explanation, media_type: data.media_type, title: data.title, url: data.url)
                        self?.presenter?.presentAPOD(response)
                }
            }
        })
    }
}
