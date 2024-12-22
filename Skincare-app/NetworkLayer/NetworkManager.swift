//
//  NetworkManager.swift
//  Skincare-app
//
//  Created by Apple on 24.09.24.
//

import Alamofire
import Foundation
import UIKit

enum CustomNetworkErrorEnum: Error {
    case invalidURL
    case noData
    case decodingError
    case unexpectedResponse
}

struct CustomNetworkError: Error{
    let code: String
    let message: String
}
class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}

    func fetch<T: Decodable>(url: String, id: Int? = nil, method: HTTPMethod, parameters: Parameters? = nil, encoding: ParameterEncoding = JSONEncoding.default, headers: HTTPHeaders? = nil, completion: @escaping (Result<T, Error>) -> Void) {
        
       
        let fullURL: String
            if let id = id {
                fullURL = "\(url)/\(id)"
            } else {
                fullURL = url
            }
            
            guard let requestURL = URL(string: fullURL) else {
                completion(.failure(CustomNetworkErrorEnum.invalidURL))
                return
            }
        
        AF.request(requestURL, method: method, parameters: parameters, encoding: encoding, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    print("Request failed with error: \(error) url: \(requestURL)")
                    completion(.failure(error))
                }
            }
    }

    func fetchWithoutResponse(url: String, method: HTTPMethod, parameters: Parameters? = nil, encoding: ParameterEncoding = JSONEncoding.default, headers: HTTPHeaders? = nil, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let requestURL = URL(string: url) else {
            completion(.failure(CustomNetworkErrorEnum.invalidURL))
            return
        }

        AF.request(requestURL, method: method, parameters: parameters, encoding: encoding, headers: headers)
            .validate(statusCode: 200..<300)
            .response { response in
                switch response.result {
                case .success:
                    completion(.success(()))
                case .failure(let error):
                    print("Request failed with error: \(error)")
                    completion(.failure(error))
                }
            }
    }
    
    func getImage(url: String, imageId: Int, headers: HTTPHeaders, completion: @escaping (UIImage?) -> Void){
        AF.request("\(url)\(imageId)", method: .get, headers: headers).responseData { response in
            switch response.result {
            case .success(let data):
                let image = UIImage(data: data)
                completion(image)
            case .failure(let error):
                    print("Error downloading image: \(error)")
                    completion(nil)
            }
        }
    }
}
