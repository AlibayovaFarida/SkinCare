//
//  RegisterViewModel.swift
//  Skincare-app
//
//  Created by Apple on 10.08.24.
//

import Foundation

class RegisterViewModel {
    private let registerService = RegisterService.shared
    
    func register(name: String, surname: String, email: String, password: String, rePassword: String, completionError: @escaping (String) -> Void){
        let request = RegisterModel.Request(name: name, surname: surname, email: email, password: password, rePassword: rePassword)
        registerService.register(request: request) { result in
            switch result {
            case .success(let data):
                print(data, "Hello")
            case .failure(let error):
                completionError(error.code)
            }
        }
    }
}
