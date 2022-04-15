//
//  SecondViewModel.swift
//  RickMorty
//
//  Created by Nodirbek on 15.04.2022.
//

import Foundation
protocol SecondViewModeling{
    func getModel()->ResultDataModel
}

final class SecondViewModel {
    
    let model: ResultDataModel
    
    init(model: ResultDataModel) {
        self.model = model
    }
    
    func getModel() -> ResultDataModel {
        model
    }
    
}
