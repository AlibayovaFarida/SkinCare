//
//  RegisterModel.swift
//  Skincare-app
//
//  Created by Apple on 23.09.24.
//

struct RegisterModel{
    struct Request: Encodable {
        let name: String
        let surname: String
        let email: String
        let password: String
        let rePassword: String
    }
    struct Response: Decodable{
        
    }
}
