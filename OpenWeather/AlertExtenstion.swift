//
//  AlertExtenstion.swift
//  OpenWeather
//
//  Created by Valerii on 11.04.2019.
//  Copyright © 2019 Valerii. All rights reserved.
//

import Foundation

import UIKit
import SVProgressHUD

extension ViewController {
    
    func showAlert(title : String, messgae : String, style : UIAlertController.Style) {
        
        let alert = UIAlertController(title: title, message: messgae, preferredStyle: style)
        let ok = UIAlertAction(title: "Ok", style: .default) { (action) in
            if let textField = alert.textFields?.first {
                self.callWeather(city: textField.text!)
                self.callWeekWeather(city: textField.text!)
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (cancel) in
        }
        alert.addAction(cancel)
        alert.addAction(ok)
        alert.addTextField { (textField) in
            textField.placeholder = "City name"
            textField.textAlignment = .center
        }
        self.present(alert, animated: true, completion: nil)
    }
}
