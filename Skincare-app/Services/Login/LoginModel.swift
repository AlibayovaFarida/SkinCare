//
//  File.swift
//  Skincare-app
//
//  Created by Apple on 07.10.24.
//

import Foundation

struct LoginModel {
    struct Request: Encodable{
        let email: String
        let password: String
    }
    struct Response: Decodable{
        let accessToken: String
        let refreshToken: String
    }
}
