//
//  NeoWSModel.swift
//  NasaApi
//
//  Created by Maxim on 02/09/2020.
//  Copyright © 2020 Maxim. All rights reserved.
//

import Foundation

enum NeoWSModel {
    
    enum FetchNeoWS{
        struct RequestDates {
            let startData: String
            let endData:String
        }
        
        struct RequestID {
            let id: Int
        }
        
        struct RequestUrl {
            let url: String
        }
    
        struct ResponseID {
            let data: NearEarthObjects
        }
        
        struct RequestDay {
            let startDay: String
            let endDay: String
        }
        
        struct ResponseDay {
            let data: NeoData
        }
    
        struct ViewModelID {
            let data: NearEarthObjects
        }
        
        struct ViewModelDay {
            let data: NeoData
        }
    }
}
