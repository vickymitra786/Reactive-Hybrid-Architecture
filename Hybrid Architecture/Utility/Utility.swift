//
//  Utility.swift
//  Hybrid Architecture
//
//  Created by vivek mitra on 26/11/18.
//  Copyright © 2018 Codeblaze. All rights reserved.
//

import Foundation
import UIKit


class Utility
{
    // MARK:- Defining a sigleton
    
    static private var sharedInstance = Utility()
    
    private init(){}
    
    static internal func getSharedInstance()-> Utility
    {
        return sharedInstance
    }
    
    
    /**
     *  method to raise an alert
     **/
    internal func raiseAlert(alertTitle: String, alertMessage: String, viewController: UIViewController)
    {
        
        let refreshAlert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
        }))
        
        viewController.present(refreshAlert, animated: true, completion: nil)
    }
}


