//
//  SkinProblemsService.swift
//  Skincare-app
//
//  Created by Apple on 05.12.24.
//

import Foundation
import Alamofire

class SkinProblemsService {
    static let shared = SkinProblemsService()
    
    private init(){}
    
    
    func skinProblems(completion: @escaping (Result<[SkinProblemsModel.SkinProblem], Error>) -> Void) {
        guard let token = UserDefaults.standard.string(forKey: "accessToken") else {
            completion(.failure(CustomNetworkErrorEnum.invalidURL)) 
            return
        }
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(token)"
        ]

        NetworkManager.shared.fetch(
            url: "http://localhost:8080/api/skin-problem",
            method: .get,
            headers: headers
        ) { (result: Result<[SkinProblemsModel.SkinProblem], Error>) in
            completion(result)
        }
    }
}
