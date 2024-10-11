//
//  UIViewController+Ext.swift
//  Skincare-app
//
//  Created by Apple on 11.10.24.
//

import Foundation
import UIKit

extension UIViewController{
    func showAlert(message: String){
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Close", style: .cancel)
        alert.addAction(alertAction)
        present(alert, animated: true)
    }
}
