//
//  ProfileService.swift
//  Skincare-app
//
//  Created by Apple on 06.01.25.
//

import Alamofire
import Foundation

class ProfileService {
    static let shared = ProfileService()

    private init() {}

    func profile(
        completion: @escaping (Result<ProfileModel.Profile, Error>) -> Void
    ) {
        guard let token = UserDefaults.standard.string(forKey: "accessToken")
        else {
            completion(.failure(CustomNetworkErrorEnum.invalidURL))
            return
        }
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(token)",
        ]

        NetworkManager.shared.fetch(
            url: "http://localhost:8080/api/user/login-user", method: .get,
            headers: headers
        ) { (result: Result<ProfileModel.Profile, Error>) in
            completion(result)
        }
    }
}
