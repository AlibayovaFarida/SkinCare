//
//  LoginService.swift
//  Skincare-app
//
//  Created by Apple on 07.10.24.
//

import Foundation
import Alamofire

class LoginService {
    static let shared = LoginService()
    
    private init(){}
    
    let headers: HTTPHeaders = [
        "Content-Type": "application/json"
    ]
    
    func login(request: LoginModel.Request, completion: @escaping (Result<LoginModel.Response, Error>) -> Void) {
        NetworkManager.shared.fetch(url: "http://localhost:8080/api/user/auth/login", method: .post,
            parameters: request.asParamaters(),
            headers: headers) { result in
            completion(result)
        }
    }
}
