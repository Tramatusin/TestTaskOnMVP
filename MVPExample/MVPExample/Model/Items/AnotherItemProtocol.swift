//
//  AnotherImerProtocol.swift
//  MVVMExample
//
//  Created by Виктор Поволоцкий on 07.08.2021.
//

import Foundation

protocol AnotherItemBase: AnyObject {
}

protocol AnotherItemProtocol: AnotherItemBase {
    associatedtype item
    var name: String { get }
    var data: item { get } 
}
