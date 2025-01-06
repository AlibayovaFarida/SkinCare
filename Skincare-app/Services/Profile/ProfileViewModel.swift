//
//  ProfileViewModel.swift
//  Skincare-app
//
//  Created by Apple on 06.01.25.
//

import Foundation

protocol ProfileDelegate: AnyObject {
    func didFetchProfile(data: ProfileModel.Profile)
}

class ProfileViewModel {
    private let profileService = ProfileService.shared
    weak var delegate: ProfileDelegate?
    
    func profile(completion: @escaping (Error) -> Void) {
        profileService.profile { result in
            switch result {
            case .success(let data):
                self.delegate?.didFetchProfile(data: data)
            case .failure(let error):
                completion(error)
            }
        }
    }
}
