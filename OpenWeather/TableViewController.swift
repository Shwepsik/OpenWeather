//
//  TableViewController.swift
//  OpenWeather
//
//  Created by Valerii on 19.04.2019.
//  Copyright © 2019 Valerii. All rights reserved.
//

import Foundation
import UIKit


class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var myTableView: UITableView!

    
    override func viewDidLoad() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        myTableView.reloadData()
    }
    
    func formatter(time: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateFromString = dateFormatter.date(from: time)
        dateFormatter.dateFormat = "HH:mm"
        let newTime = dateFormatter.string(from: dateFromString!)
        return newTime
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dayTitles[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return daySections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let key = daySections[section]
        if let animavValues = weatherDict[key] {
            return animavValues.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! Cells
        
        let dayKey = daySections[indexPath.section]
        if let weekDay = weatherDict[dayKey] {
            cell.descrLable.text = weekDay[indexPath.row].description
            cell.timeLable.text = formatter(time: weekDay[indexPath.row].calendar)
            cell.degreesLable.text = ("\(weekDay[indexPath.row].temperature)°")
            cell.weatherImage.image = UIImage(named: weekDay[indexPath.row].weatherImage)
        }
        return cell
    }
}




