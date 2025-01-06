//
//  ConsultationViewModel.swift
//  Skincare-app
//
//  Created by Apple on 02.01.25.
//

import Foundation

protocol ConsultationDelegate: AnyObject {
    func didFetchDermatologist(data: [DermatologistModel.Dermatologist])
}

class ConsultationViewModel {
    private var query: [String : Any]
    init(query: [String : Any] ) {
        self.query = query
    }
    private let consultationService = ConsultationService.shared
    
    weak var delegate: ConsultationDelegate?
    
    func consultation(completion: @escaping (Error) -> Void) {
        consultationService.consultation(query: query) { result in
            switch result {
            case .success(let data):
                self.delegate?.didFetchDermatologist(data: data)
            case .failure(let error):
                completion(error)
            }
        }
    }
}
