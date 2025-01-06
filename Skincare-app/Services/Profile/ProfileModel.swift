//
//  ProfileModel.swift
//  Skincare-app
//
//  Created by Apple on 06.01.25.
//

import Foundation

struct ProfileModel {
    typealias Response = Profile
    
    struct Profile: Decodable {
        let name: String
        let surname: String
        let email: String
    }
}
