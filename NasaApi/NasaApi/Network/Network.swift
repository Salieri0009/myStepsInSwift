//
//  Network.swift
//  NasaApi
//
//  Created by Maxim on 02/09/2020.
//  Copyright © 2020 Maxim. All rights reserved.
//

import Foundation
import UIKit
// MARK: модуль работы с сетью
class Network {
    let getApodDataURL = "https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY"
    let getNeoWSDataURL = "https://api.nasa.gov/neo/rest/v1/"
    
    let apiKey = "api_key=DEMO_KEY"
    
    func getApodData(completion: @escaping ((Result<ApodData, Error>) -> Void)) {
        guard let url = URL(string: getApodDataURL) else {return}
        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
                    if let error = error {
                        print(error)
                        completion(.failure(error))
                        return
                    }
                    
                if let data = data {
                    let json = try? JSONDecoder().decode(ApodData.self, from: data)
                    if let json = json {
                        print(json)
                        completion(.success(json))
                    }
                }
            }
            task.resume()
        }
    
    func getNeoWSDataFromDays(startDate: String, endDate: String, completion: @escaping ((Result<NeoData, Error>) -> Void)) {
        let str = getNeoWSDataURL + "feed?start_date=" + startDate + "&end_date=" + endDate + "&" + apiKey
        guard let url = URL(string: str) else {return}
        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            if let error = error {
                print(error)
                completion(.failure(error))
                return
            }
            if let data = data {
                let json = try? JSONDecoder().decode(NeoData.self, from: data)
                if let json = json{
                    print(json)
                    completion(.success(json))
                }
            }
        }
        task.resume()
    }
    
    func getNeoWsDataFromID(ID: Int, completion: @escaping ((Result<NearEarthObjects, Error>) -> Void)) {
        let str = getNeoWSDataURL + "neo/" + String(ID) + "?" + apiKey
        guard let url = URL(string: str) else {return}
        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            if let error = error {
                print(error)
                completion(.failure(error))
                return
            }
            if let data = data {
                let json = try? JSONDecoder().decode(NearEarthObjects.self, from: data)
                if let json = json{
                    print(json)
                    completion(.success(json))
                }
            }
        }
        task.resume()
    }
    
    func loadImg(url: String, completion: @escaping ((Result<UIImage, Error>) -> Void)){
        guard let url = URL(string: url) else {return}
        let task = URLSession.shared.dataTask(with: url){
            (data, response, error) in
            if let error = error {
                print(error)
                completion(.failure(error))
                return
            }
            if let data = data {
                guard let img = UIImage(data: data) else {return}
                completion(.success(img))
            }
        }
        task.resume()
    }
    
    func getNeoWSFromUrl(str: String, completion: @escaping ((Result<NeoData, Error>) -> Void)){
        var url = str
        if !url.contains("https") {
            let index = url.index(url.startIndex, offsetBy: 4)
            url.insert("s", at: index)
        }
        guard let requestUrl = URL(string: url) else {return}
        let task = URLSession.shared.dataTask(with: requestUrl) {
            (data, response, error) in
            if let error = error {
                print(error)
                completion(.failure(error))
                return
            }
            if let data = data {
                let json = try? JSONDecoder().decode(NeoData.self, from: data)
                if let json = json{
                    print(json)
                    completion(.success(json))
                }
            }
        }
        task.resume()
    }
}

