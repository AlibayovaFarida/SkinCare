//
//  ProductsViewModel.swift
//  Skincare-app
//
//  Created by Apple on 09.12.24.
//

import Foundation

protocol ProductsDelegate: AnyObject {
    func didFetchProducts(data: [ProductsModel.Product])
}

class ProductsViewModel {
    private let productsService = ProductsService.shared
    
    weak var delegate: ProductsDelegate?
    
    func products(completion: @escaping (Error) -> Void){
        productsService.products { result in
            switch result {
            case .success(let data):
                self.delegate?.didFetchProducts(data: data)
            case .failure(let error):
                completion(error)
            }
        }
    }
}
