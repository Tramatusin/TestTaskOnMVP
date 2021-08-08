//
//  ImageDataManager.swift
//  MVVMExample
//
//  Created by Виктор Поволоцкий on 07.08.2021.
//

import Foundation

class Image: AnotherItemProtocol{
    typealias item = (text: String?,urldata: Data?)
    
    let name: String
    
    let data: (text: String?,urldata: Data?)
    
    init(name: String, data: (String?,Data?)) {
        self.name = name
        self.data = data
    }
    
}
