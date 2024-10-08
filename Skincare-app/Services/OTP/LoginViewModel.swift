//
//  LoginViewModel.swift
//  Skincare-app
//
//  Created by Apple on 07.10.24.
//

import Foundation

class LoginViewModel {
    var onSuccess: (() -> Void)?
    private let loginService = LoginService.shared
    func login(email: String, password: String, completion: @escaping (Error) -> Void){
        let request = LoginModel.Request(email: email, password: password)
        loginService.login(request: request) { result in
            switch result {
            case .success(let data):
                UserDefaults.standard.setValue(data.accessToken, forKey: "accessToken")
                UserDefaults.standard.setValue(data.refreshToken, forKey: "refreshToken")
                self.onSuccess?()
            case .failure(let error):
                completion(error)
            }
        }
    }
}
