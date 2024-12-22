//
//  ProductsModel.swift
//  Skincare-app
//
//  Created by Apple on 09.12.24.
//

import Foundation

struct ProductsModel: Equatable {
    typealias Response = [Product]
    
    struct Product: Decodable, Equatable {
        let id: Int
        let title: String
        let imageIds: [Int]
    }
}
