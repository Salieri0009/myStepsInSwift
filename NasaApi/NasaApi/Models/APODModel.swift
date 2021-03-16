//
//  APODModel.swift
//  NasaApi
//
//  Created by Maxim on 02/09/2020.
//  Copyright © 2020 Maxim. All rights reserved.
//

import Foundation

enum APODModels {
    
    enum FetchAPOD {
        // Запрос к Interactor из ViewController
        
        struct Request {
            
        }
        // Запрос к Presentor из Interactor
        
        struct Response {
            let date: String
            let explanation: String
            let media_type: String
            let title: String
            let url: String
        }
        
        struct ViewModel {
            let date: String
            let explanation: String
            let media_type: String
            let title: String
            let url: String
        }
    }
}
