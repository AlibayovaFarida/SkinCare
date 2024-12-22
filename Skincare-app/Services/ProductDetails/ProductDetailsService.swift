//
//  ProductDetailsService.swift
//  Skincare-app
//
//  Created by Apple on 18.12.24.
//

import Foundation
import Alamofire

class ProductDetailsService {
    static let shared = ProductDetailsService()
    
    private init() {}
    
    func productDetails(
        id: Int,
        completion: @escaping (
            Result<ProductDetailsModel.ProductDetail, Error>
        ) -> Void
    ) {
        guard let token = UserDefaults.standard.string(forKey: "accessToken")
        else {
            completion(.failure(CustomNetworkErrorEnum.invalidURL))
            return
        }
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(token)"
        ]
        
        NetworkManager.shared.fetch(
            url: "http://localhost:8080/api/product",
            id: id,
            method: .get,
            headers: headers) { (result: Result<ProductDetailsModel.ProductDetail, Error>) in
                completion(result)
            }
    }
}
