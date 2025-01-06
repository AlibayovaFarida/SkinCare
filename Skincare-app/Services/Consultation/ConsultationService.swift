//
//  ConsultationService.swift
//  Skincare-app
//
//  Created by Apple on 02.01.25.
//

import Alamofire
import Foundation

class ConsultationService {
    static let shared = ConsultationService()

    private init() {}

    func consultation(
        query: [String: Any],
        completion: @escaping (Result<[DermatologistModel.Dermatologist], Error>)
            -> Void
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
        let queryString = query.map { "\($0.key)=\($0.value)" }.joined(
            separator: "&")
        let url = "http://localhost:8080/api/consultation?\(queryString)"
        NetworkManager.shared.fetch(url: url, method: .get, headers: headers) {
            (result: Result<[DermatologistModel.Dermatologist], Error>) in
            completion(result)
        }
    }
}
