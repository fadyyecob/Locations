//
//  UIAlertViewController+alerts.swift
//  Locations
//
//  Created by Fady Yecob on 19/09/2021.
//

import UIKit

extension UIAlertController {
    static func makeOKAlert(title: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .default, handler: nil))
        return alert
    }
    
    static func makeLongitudeLatitudeAlert(prefferedActionHandler: ((UIAlertController) -> Void)? = nil) -> UIAlertController {
        let alertController = UIAlertController(title: "Enter Location", message: nil, preferredStyle: .alert)
        
        alertController.addTextField {
            $0.placeholder = "Longitude"
        }
        
        alertController.addTextField {
            $0.placeholder = "Latitude"
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancelAction)
        
        let preferredAction = UIAlertAction(title: "Go", style: .default) { _ in 
            prefferedActionHandler?(alertController)
        }
        alertController.addAction(preferredAction)
        alertController.preferredAction = preferredAction
        
        return alertController
    }
}
