//
//  GetWeatherResponse.swift
//  OpenWeather
//
//  Created by Valerii on 18.04.2019.
//  Copyright © 2019 Valerii. All rights reserved.
//

import Foundation

class GetWeatherResponse {
    
    var weather: [ForecastModel]
    
    init?(json: JSON) {
        guard let list = json["list"] as? [JSON] else {
            return nil
        }
        
        let weather = list.map{ ForecastModel(json: $0) }.compactMap{ $0 }
        self.weather = weather
    }    
}
