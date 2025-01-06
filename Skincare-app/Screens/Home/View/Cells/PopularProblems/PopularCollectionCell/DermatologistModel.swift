//
//  DermatologistModel.swift
//  Skincare-app
//
//  Created by Apple on 21.08.24.
//

//struct DermatologistModel{
//    let name: String
//    let profession: String
//    let rating: Float
//    let patientCount: Int
//    let price: Int
//    let experience: Int
//    let image: String
//    var isAnimatedDone: Bool = false
//}

struct DermatologistModel {
    typealias Response = [Dermatologist]
    
    struct Dermatologist: Decodable {
        let id: Int
        let name: String
        let speciality: String
        let perHourPrice: Int
        let experience: Int
        let rating: Float
        let review: Int
        let imageIds: [Int]
//        var isAnimatedDone: Bool? = false
    }
}
