//
//  APODPresenter.swift
//  NasaApi
//
//  Created by Maxim on 02/09/2020.
//  Copyright © 2020 Maxim. All rights reserved.
//

import Foundation
import UIKit

protocol APODPresentationLogic: class {
    // формирование полученных данных
    func presentAPOD(_ response: APODModels.FetchAPOD.Response)
}

class ApodPresenter: APODPresentationLogic {
    
    weak var viewController: APODDisplayLogic?
    
    func presentAPOD(_ response: APODModels.FetchAPOD.Response) {
        let viewModel = APODModels.FetchAPOD.ViewModel(date: response.date, explanation: response.explanation, media_type: response.media_type, title: response.title, url: response.url)
        
        viewController?.displayAPODData(viewModel)
    }
    
}
