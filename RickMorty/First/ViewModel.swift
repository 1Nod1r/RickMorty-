//
//  ViewModel.swift
//  RickMorty
//
//  Created by Nodirbek on 14.04.2022.
//

import Foundation

protocol ViewModeling: AnyObject {
    
    var didChange: (() -> Void)? { get set }
    
    func getData(with page:Int)
    func numberOfRows() -> Int
    func item(for index: Int) -> ResultDataModel

}

 final class ViewModel {
    
    private let networkManager = NetworkManager()
    
    var didChange: (() -> Void)?
    

    
    private var items: [ResultDataModel] = [] {
        didSet {
            didChange?()
        }
    }
    
}
    
// MARK: - ViewModeling
extension ViewModel: ViewModeling {
    
    func getData(with page: Int) {
        networkManager.getData { result in
            switch result {
            case .success(let data):
                self.items = data
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func numberOfRows() -> Int {
        items.count
    }
    
    func item(for index: Int) -> ResultDataModel {
        items[index]
    }
    
}
