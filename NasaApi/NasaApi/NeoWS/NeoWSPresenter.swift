//
//  NeoWSPresenter.swift
//  NasaApi
//
//  Created by Maxim on 02/09/2020.
//  Copyright © 2020 Maxim. All rights reserved.
//

import Foundation

protocol NeoWSPresentationLogic: class {
    // формирование полученных данных
    func presentNeoWSCell(_ response: NeoWSModel.FetchNeoWS.ResponseDay)
    
    func presentNeoWSFromID(_ response: NeoWSModel.FetchNeoWS.ResponseID)
}

class NeoWSPresenter: NeoWSPresentationLogic {
    weak var viewController: NeoWSDisplayLogic?
    
    func presentNeoWSFromID(_ response: NeoWSModel.FetchNeoWS.ResponseID) {
        
    }
    
    func presentNeoWSCell(_ response: NeoWSModel.FetchNeoWS.ResponseDay) {
        let viewModelPresentCell = NeoWSModel.FetchNeoWS.ViewModelDay(data: response.data)
        viewController?.displayNeoWSCellData(viewModelPresentCell)
    }
}
