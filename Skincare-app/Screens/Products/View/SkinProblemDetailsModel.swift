//
//  SkinProblemDetailsModel.swift
//  Skincare-app
//
//  Created by Apple on 12.12.24.
//

struct SkinProblemDetailsModel {
    typealias Response = SkinProblemDetail

    struct SkinProblemDetail: Decodable {
        let id: Int
        let title: String
        let detail: String
        let imageIds: [Int]
        let information: [Information]
    }
    struct Information: Decodable {
        let id: Int
        let question: String
        let answer: String
    }
}
