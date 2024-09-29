//
//  OTPModel.swift
//  Skincare-app
//
//  Created by Apple on 29.09.24.
//

struct OTPModel {
    struct Request: Encodable {
        let email: String
        let otpCode: String
    }
    struct Response: Decodable{
        
    }
}
