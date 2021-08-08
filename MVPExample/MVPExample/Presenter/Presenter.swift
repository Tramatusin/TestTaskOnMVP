//
//  ViewModel.swift
//  MVVMExample
//
//  Created by Виктор Поволоцкий on 07.08.2021.
//

import Foundation
import UIKit

protocol PresenterDelegate: AnyObject{
    var itemsData: ([AnotherItemBase]?,[String]) { get set }
    
    func setCarthage()
}

protocol PresenterInput : AnyObject{
    func setDataInView(items: (elements: [AnotherItemBase]?,queue: [String]))
}

class Presenter: PresenterDelegate{
    weak var view: PresenterInput!
    var networkManager: NetworkManager!
    
    var itemsData: ([AnotherItemBase]?, [String]) = (nil,[""])
    
    func setCarthage() {
        DispatchQueue.global().async {
            self.networkManager.getData {[weak self] item in
                self?.itemsData = item
                DispatchQueue.main.async {
                    guard let item = self?.itemsData else {return}
                    self?.view?.setDataInView(items: item)
                }
            }
        }
    }
}
