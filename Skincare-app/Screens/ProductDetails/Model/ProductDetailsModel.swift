//
//  ProductDetailsModel.swift
//  Skincare-app
//
//  Created by Apple on 19.12.24.
//

import Foundation

struct ProductDetailsModel {
    typealias Response = ProductDetail

    struct ProductDetail: Decodable {
        let id: Int
        let title: String
        let detail: String
        let imageIds: [Int]
        let information: [Information]
    }
    struct Information: Decodable {
        let question: String
        let answer: String
    }
}
