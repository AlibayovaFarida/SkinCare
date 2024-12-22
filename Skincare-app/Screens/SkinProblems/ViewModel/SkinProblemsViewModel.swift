//
//  SkinProblemsViewModel.swift
//  Skincare-app
//
//  Created by Apple on 05.12.24.
//

import Foundation

protocol SkinProblemsDelegate: AnyObject {
    func didFetchSkinProblems(data: [SkinProblemsModel.SkinProblem])
}

class SkinProblemsViewModel {
    private let skinProblemsService = SkinProblemsService.shared
    weak var delegate: SkinProblemsDelegate?

    func skinProblems(completion: @escaping (Error) -> Void) {
        skinProblemsService.skinProblems { result in
            switch result {
            case .success(let data):
                self.delegate?.didFetchSkinProblems(data: data)
            case .failure(let error):
                completion(error)
            }

        }
    }
}
