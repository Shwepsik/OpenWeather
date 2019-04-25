//
//  ApiCall.swift
//  OpenWeather
//
//  Created by Valerii on 10.04.2019.
//  Copyright © 2019 Valerii. All rights reserved.
//

import Foundation
import Alamofire


typealias JSON = [String: AnyObject]
typealias ResponseBlock = (_ result: Any?, _ error: Error?)
    -> Void

class ApiCall {
    
    
    var cityForecast = String()
    
    static let shared = ApiCall()

    let baseUrl: String = "https://api.openweathermap.org/data/2.5/"
    
    
    func tryLoadWeather(method: HTTPMethod, params: Parameters?, headers: HTTPHeaders?, path: String, responseBlock: @escaping ResponseBlock) {
        
        let fullPath: String = baseUrl + path
        
        if let url: URL = URL(string: fullPath) {
            
            request(url, method: method, parameters: params, headers: headers).validate().responseJSON { (responseJSON) in
                switch responseJSON.result {
                case .success:
                    guard let jsonArray = responseJSON.result.value as? JSON else {
                        return
                    }
                    
                    responseBlock(jsonArray,nil)

                    
                case .failure(let error):
                    responseBlock(nil,error)
                    
                }
            }
        }
    }
    
    
    func getWeatherRequest(city: String, _ resposeBlock: @escaping ResponseBlock) {
        tryLoadWeather(method: .get, params: ["q": city,"appid": "fc22b8e7f202e3d8eb3672de7c0c84e5"], headers: nil, path: "weather") { (response,error) in
            
            if let json = response as? JSON {
                
                let weatherModel = WeatherModel(json: json)
                resposeBlock(weatherModel, nil)
            } else {
    
                resposeBlock(nil,error)
            }
        }
    }
    
    
    func getWeatherForecast(city: String, _ resposeBlock: @escaping (GetWeatherResponse) -> Void) {
        tryLoadWeather(method: .get, params: ["q": city,"appid": "fc22b8e7f202e3d8eb3672de7c0c84e5"], headers: nil, path: "forecast") { (response, error) in
            
            if let json = response as? JSON {
                let getWeatherResponse = GetWeatherResponse(json: json)
                resposeBlock(getWeatherResponse!)
            }
        }
    }
}
