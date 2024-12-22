//
//  SkinProblemDetailsViewModel.swift
//  Skincare-app
//
//  Created by Apple on 12.12.24.
//

import Foundation

protocol SkinProblemDetailsDelegate: AnyObject {
    func didFetchSkinProblemDetails(data: SkinProblemDetailsModel.SkinProblemDetail)
}

class SkinProblemDetailsViewModel {
    private var id: Int
    init(id: Int) {
        self.id = id
    }
    weak var delegate: SkinProblemDetailsDelegate?
    private let skinProblemDetailsService = SkinProblemDetailsService.shared
    
    func skinProblemDetails(completion: @escaping (Error) -> Void) {
        skinProblemDetailsService.skinProblemDetails(id: id) { result in
            switch result {
            case .success(let data):
                self.delegate?.didFetchSkinProblemDetails(data: data)
            case .failure(let error):
                completion(error)
            }
        }
    }
}
