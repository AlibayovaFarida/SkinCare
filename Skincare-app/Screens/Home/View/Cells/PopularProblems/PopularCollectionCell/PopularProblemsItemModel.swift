//
//  PopularProblemsItemModel.swift
//  Skincare-app
//
//  Created by Apple on 15.08.24.
//

struct PopularProblemsItemModel: Equatable {
    let image: String
    let title: String
    let solutions: [String]
    var isAnimatedDone: Bool = false
}

