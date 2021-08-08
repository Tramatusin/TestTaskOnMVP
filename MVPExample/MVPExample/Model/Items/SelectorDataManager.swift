//
//  SelectorDataManager.swift
//  MVVMExample
//
//  Created by Виктор Поволоцкий on 07.08.2021.
//

import Foundation

class Selector: AnotherItemProtocol{
    typealias item = [(descript: String?,id: Int?)]
    
    let name: String
    
    let data: [(descript: String?,id: Int?)]
    
    let SelectedID: Int?
    
    init(name: String, data: [(String?,Int?)],selectedID: Int?) {
        self.name = name
        self.data = data
        self.SelectedID = selectedID
    }
}
