//
//  SkinProblemsModel.swift
//  Skincare-app
//
//  Created by Apple on 05.12.24.
//

import Foundation

struct SkinProblemsModel: Equatable {
    typealias Response = [SkinProblem]

    struct SkinProblem: Equatable, Decodable {
        let id: Int
        let title: String
        let imageIds: [Int]
    }
}
