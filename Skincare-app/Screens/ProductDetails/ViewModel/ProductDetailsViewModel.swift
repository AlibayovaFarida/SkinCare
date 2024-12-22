//
//  ProductDetailsViewModel.swift
//  Skincare-app
//
//  Created by Apple on 18.12.24.
//

import Foundation

protocol ProductDetailsDelegate: AnyObject {
    func didFetchProductDetails(data: ProductDetailsModel.ProductDetail)
}

class ProductDetailsViewModel{
    private var id: Int
    init(id: Int) {
        self.id = id
    }
    weak var delegate: ProductDetailsDelegate?
    private let productDetailsService = ProductDetailsService.shared
    
    func productDetails(completion: @escaping (Error) -> Void) {
        productDetailsService.productDetails(id: id) { result in
            switch result {
            case .success(let data):
                print(data, "products")
                self.delegate?.didFetchProductDetails(data: data)
            case .failure(let error):
                completion(error)
            }
        }
    }
}
