//
//  Helper.swift
//  Pokemon
//
//  Created by Craig Briggs on 4/09/17.
//  Copyright © 2017 Craig Briggs. All rights reserved.
//
import UIKit
import Foundation

class Helper {
    
    /// Displays an alert with OK to dismiss button
    ///
    /// - Parameters:
    ///   - VC: Viewcontroller alert is attached to
    ///   - title: title description
    ///   - message: message description
    ///   - callBack: callback function, can be nil
    static func showAlert(VC:UIViewController, title: String, message: String, callBack:  ((UIAlertAction)  -> ())? = nil) {
        /// Display an alert explaining that local values are being used
        let alertController = UIAlertController(title: title, message:
            message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: callBack))
        VC.present(alertController, animated: true, completion: nil)
    }
    
}
