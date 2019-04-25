//
//  ForecastModel.swift
//  OpenWeather
//
//  Created by Valerii on 17.04.2019.
//  Copyright © 2019 Valerii. All rights reserved.
//

import Foundation
import UIKit



struct ForecastModel {
    
    var calendar: String
    var temperature: String
    var description: String
    var weatherImage: String
    
    init?(json: JSON) {
        
        guard let calendar = json["dt_txt"] as? String,
        let main = json["main"] as? [String: AnyObject],
        let temp = main["temp"] as? Double,
        let weatherDescription = json["weather"] as? [[String: AnyObject]],
        let description = weatherDescription[0]["description"] as? String,
        let icon = weatherDescription[0]["icon"] as? String else {
            return nil
        }
        
       // let dateFormatter = DateFormatter()
       // dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
       // let dateFromString = dateFormatter.date(from: calendar)
       // dateFormatter.dateFormat = "EEEE HH:mm:ss"
      //  let newDate = dateFormatter.string(from: dateFromString!)
        
        self.calendar = calendar
        let intT = Int(temp) - 273
        self.temperature = String(intT)
        self.description = description
        self.weatherImage = icon
       // self.sections = [Sections(calendar: calendar, day: calendar)]
        
    }
}
