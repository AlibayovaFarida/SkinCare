//
//  NetworkManager.swift
//  Skincare-app
//
//  Created by Apple on 24.09.24.
//

import Alamofire
import Foundation

struct CustomNetworkError: Error, Decodable {
    let code: String
    let message: String
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init(){}
    
    func fetch<T: Decodable>(url: String, method: HTTPMethod = .get, bodyParametrs: Parameters? = nil, headers: HTTPHeaders, completion: @escaping (Result<T, CustomNetworkError>) -> Void){
        guard let url = URL(string: url) else {
            return
        }
        
        AF.request(url, method: method, parameters: bodyParametrs, headers: headers).validate().responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure:
                guard let data = response.data else {
                    print("Response data is nil")
                    return
                }
        
                do{
                    let errorModel = try JSONDecoder().decode(CustomNetworkError.self, from: data)
                    completion(.failure(errorModel))
                } catch{
                    print("Error model decoding failed", error)
                }
            }
        }
    }
}
