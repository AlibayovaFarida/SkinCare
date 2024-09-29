//
//  NetworkManager.swift
//  Skincare-app
//
//  Created by Apple on 24.09.24.
//

import Alamofire
import Foundation

enum CustomNetworkErrorEnum: Error {
    case invalidURL
    case noData
    case decodingError
    case unexpectedResponse
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}

    func fetch<T: Decodable>(url: String, method: HTTPMethod, parameters: Parameters? = nil, encoding: ParameterEncoding = JSONEncoding.default, headers: HTTPHeaders? = nil, completion: @escaping (Result<T, Error>) -> Void) {
        guard let requestURL = URL(string: url) else {
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
                    print("Request failed with error: \(error)")
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
}
