//
//  OTPService.swift
//  Skincare-app
//
//  Created by Apple on 29.09.24.
//

import Foundation
import Alamofire

class OTPService {
    static let shared = OTPService()
    
    private init() {}
    
    let headers: HTTPHeaders = [
        "Content-Type": "application/json"
    ]
    
    func otpCode(request: OTPModel.Request, completion: @escaping (Result<Void, Error>) -> Void) {
        NetworkManager.shared.fetchWithoutResponse(url: "http://localhost:8080/api/user/auth/otp",
            method: .post,
            parameters: try? request.asParamaters(),
            headers: headers
        ) { result in
            completion(result)
        }
    }
}
