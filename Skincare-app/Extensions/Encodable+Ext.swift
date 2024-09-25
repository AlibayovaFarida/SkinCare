//
//  Encodable+Ext.swift
//  Skincare-app
//
//  Created by Apple on 25.09.24.
//

import Foundation
import Alamofire

extension Encodable {
    func asParamaters() -> Parameters? {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(self)
            let dictionary = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? Parameters
            return dictionary
        }
        catch {
            print("Error converting to dictionary: \(error)")
            return nil
        }
    }
}
