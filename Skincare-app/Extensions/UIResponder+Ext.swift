//
//  UIResponder.swift
//  Skincare-app
//
//  Created by Apple on 15.08.24.
//

import UIKit

extension UIResponder {
    func findViewController() -> UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next {
            return nextResponder.findViewController()
        } else {
            return nil
        }
    }
}
