//
//  NeoWSInteractor.swift
//  NasaApi
//
//  Created by Maxim on 02/09/2020.
//  Copyright © 2020 Maxim. All rights reserved.
//

import Foundation

protocol NeoWSBusnessLogic: class {
    
    //отображение данных
    func fetchNeoWSDataFromDates(_ request: NeoWSModel.FetchNeoWS.RequestDates)
    
    func fetchNeoWSDataFromID(_ request: NeoWSModel.FetchNeoWS.RequestID)
    
    func fetchNeoWSdataFromUrl(_ request: NeoWSModel.FetchNeoWS.RequestUrl)
}

class NeoWSInteractor: NeoWSBusnessLogic {
    
    let network = Network()
    
    var presenter: NeoWSPresentationLogic?
    
    func fetchNeoWSDataFromID(_ request: NeoWSModel.FetchNeoWS.RequestID) {
        
    }
    
    func fetchNeoWSDataFromDates(_ request: NeoWSModel.FetchNeoWS.RequestDates) {
        network.getNeoWSDataFromDays(startDate: request.startData, endDate: request.endData, completion: {
            [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let data):
                DispatchQueue.main.async {
                    print(data)
                    let response = NeoWSModel.FetchNeoWS.ResponseDay(data: data)
                    self?.presenter?.presentNeoWSCell(response)
                }
            }
        })
    }
    
    func fetchNeoWSdataFromUrl(_ request: NeoWSModel.FetchNeoWS.RequestUrl){
        network.getNeoWSFromUrl(str: request.url, completion: {
            [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let neoData):
                DispatchQueue.main.async {
                    print(neoData)
                    let response = NeoWSModel.FetchNeoWS.ResponseDay(data: neoData)
                    self?.presenter?.presentNeoWSCell(response)
                }
            }
        })
    }
}
