//
//  LoginService.swift
//  Skincare-app
//
//  Created by Apple on 24.09.24.
//

import Foundation

class RegisterService{
    static let shared = RegisterService()
    
    private init() {}
    
    func register(request: RegisterModel.Request, completion: @escaping (Result<RegisterModel.Response, CustomNetworkError>) -> Void) {
        NetworkManager.shared.fetch(
            url: "http://localhost:8080/api/user/auth/register",
            method: .post,
            bodyParametrs: request.asParamaters(),
            headers: [.contentType("application/json")]
        ) { (result: Result<RegisterModel.Response, CustomNetworkError>) in
            completion(result)
        }
    }
    
}
