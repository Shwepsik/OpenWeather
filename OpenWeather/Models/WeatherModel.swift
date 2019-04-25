//
//  WeatherModel.swift
//  OpenWeather
//
//  Created by Valerii on 10.04.2019.
//  Copyright © 2019 Valerii. All rights reserved.
//

import Foundation


struct WeatherModel {
    
    var cityName: String
    var temp: String
    var humidity: String
    var pressure: String
    var description: String
    var icon: String
    var id: Int
    var date: String
    var windSpeed: String
    
    init?(json: JSON) {
        guard let main = json["main"] as? [String: AnyObject],
        let dateTime = json["dt"] as? Double,
        let humidity = main["humidity"] as? Int,
        let cityName = json["name"] as? String,
        let tempDouble = main["temp"] as? Double,
        let pressure = main["pressure"] as? Int,
        let weatherDescr = json["weather"] as? [[String: AnyObject]],
        let description = weatherDescr[0]["description"] as? String,
        let icon = weatherDescr[0]["icon"] as? String,
        let wind = json["wind"] as? [String: AnyObject],
        let windSpeed = wind["speed"] as? Double,
        let id = weatherDescr[0]["id"] as? Int else {
                return nil
        }
        
        self.cityName = cityName
        print("\(cityName)fsdfsfsddsf")
        let convert = Int(tempDouble) - 273
        self.temp = String(convert)
        self.humidity = String(humidity)
        self.pressure = String(pressure)
        self.description = description
        self.icon = icon
        self.id = id
        let windInt = Int(windSpeed)
        self.windSpeed = String(windInt)
        let dateInt = Date(timeIntervalSince1970: dateTime)
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "HH:mm"
        self.date = dateFormater.string(from: dateInt)
    }
}
