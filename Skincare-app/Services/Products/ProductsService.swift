//
//  ProductsService.swift
//  Skincare-app
//
//  Created by Apple on 09.12.24.
//

import Foundation
import Alamofire

class ProductsService {
    static let shared = ProductsService()
    
    private init(){}
    
    func products(completion: @escaping(Result<[ProductsModel.Product], Error>) -> Void){
        
        guard let token = UserDefaults.standard.string(forKey: "accessToken") else {
            completion(.failure(CustomNetworkErrorEnum.invalidURL))
            return
        }
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(token)"
        ]
        
        NetworkManager.shared.fetch(url: "http://localhost:8080/api/product", method: .get, headers: headers) { (result: Result<[ProductsModel.Product],Error>) in
            completion(result)
        }
    }
}
