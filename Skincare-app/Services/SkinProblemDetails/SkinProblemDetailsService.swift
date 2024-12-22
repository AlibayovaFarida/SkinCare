//
//  SkinProblemDetailsService.swift
//  Skincare-app
//
//  Created by Apple on 12.12.24.
//

import Alamofire
import Foundation

class SkinProblemDetailsService {
    static let shared = SkinProblemDetailsService()

    private init() {}

    func skinProblemDetails(
        id: Int,
        completion: @escaping (
            Result<SkinProblemDetailsModel.SkinProblemDetail, Error>
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
            url: "http://localhost:8080/api/skin-problem/details",
            id: id,
            method: .get,
            headers: headers
        ) {
            (result: Result<SkinProblemDetailsModel.SkinProblemDetail, Error>)
            in
            completion(result)
        }
    }
}
