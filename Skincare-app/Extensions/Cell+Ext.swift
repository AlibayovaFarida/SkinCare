//
//  Cell+Ext.swift
//  Skincare-app
//
//  Created by Apple on 10.08.24.
//

import Foundation
import UIKit

extension UICollectionViewCell{
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell{
    static var identifier: String {
        return String(describing: self)
    }
}

