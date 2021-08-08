//
//  LabelDataManager.swift
//  MVVMExample
//
//  Created by Виктор Поволоцкий on 07.08.2021.
//

import Foundation

class Label: AnotherItemProtocol{
    typealias item = String?
    
    let name: String

    let data: String?
    
    init(name: String, data: String?) {
        self.name = name
        self.data = data
    }
}
