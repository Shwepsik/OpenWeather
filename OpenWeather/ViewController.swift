//
//  ViewController.swift
//  OpenWeather
//
//  Created by Valerii on 10.04.2019.
//  Copyright © 2019 Valerii. All rights reserved.
//

import UIKit


var daySections = [String]()
var dayTitles = [String]()
var weatherDict = [String: [ForecastModel]]()

class ViewController: UIViewController {
    
    
    var formatterArray = [String]()
    
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var degrees: UILabel!
    @IBOutlet weak var humidityLable: UILabel!
    @IBOutlet weak var pressureLable: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var windSpeed: UILabel!
    
    
    
    @IBAction func findCity(_ sender: UIButton) {
        showAlert(title: "City", messgae: "Enter name city", style: .alert)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LocationController.shared.getLocation { (city,erro) in
            if erro != nil {
                print("hyuita")
            } else {
                Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { (Timer) in
                   self.callWeather(city: city!)
                   self.callWeekWeather(city: city!)
                })
            }
        }
    }
    
    func callWeekWeather(city: String) {
        ApiCall.shared.getWeatherForecast(city: city) { (response) in
            self.splitArray(array: response.weather)
        }
    }
    
    func formatterDayOfWeek(date: [String]) -> [String] {
        formatterArray.removeAll()
        let dateFormatter = DateFormatter()
        for i in date {
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateFromString = dateFormatter.date(from: i)
            dateFormatter.dateFormat = "EEEE MMM dd"
            let newDate = dateFormatter.string(from: dateFromString!)
            formatterArray.append(newDate)
        }
        return formatterArray
    }
    
    func splitArray(array: [ForecastModel]) {
        weatherDict.removeAll()
        for i in array {
            let reqIndex = i.calendar.index(i.calendar.startIndex, offsetBy: 10)
            let finalStr = String(i.calendar[..<reqIndex])
            
            if var filteredValue = weatherDict[finalStr] {
                filteredValue.append(i)
                weatherDict[finalStr] = filteredValue
            } else {
                weatherDict[finalStr] = [i]
            }
        }
        daySections = [String](weatherDict.keys)
        daySections = daySections.sorted(by: { $0 < $1 })
        
        dayTitles = formatterDayOfWeek(date: daySections)
        dayTitles[0] = "Today"
    }
    
    
    func callWeather(city: String) {
        ApiCall.shared.getWeatherRequest(city: city) { (models, error) in
            if let model = models as? WeatherModel {
                self.cityName.text = model.cityName
                self.imageView.image = UIImage(named: model.icon)
                self.degrees.text = ("\(model.temp)° | \(model.description)")
                self.pressureLable.text = ("\(model.pressure) hPa")
                self.humidityLable.text = ("\(model.humidity) %")
                self.windSpeed.text = ("\(model.windSpeed) km/h")
            } else {
                self.showAlert(title: error?.localizedDescription ?? "", messgae: "", style: .alert)
            }
        }
    }
}
