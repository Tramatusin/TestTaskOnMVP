//
//  NetworkManager.swift
//  MVVMExample
//
//  Created by Виктор Поволоцкий on 06.08.2021.
//

import Foundation
import SwiftyJSON

protocol NetworkManager {
    func getData(completion: @escaping ((items: [AnotherItemBase]?,view: [String]))->())
}

class NetworkManagerImplementation: NetworkManager{
    
    private let urlString: String = "https://pryaniky.com/static/json/sample.json"
    
    func getData(completion:@escaping ((items: [AnotherItemBase]?,view: [String]))->()){
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) {[weak self] data, response, error in
            guard let data = data else { return }
            
            guard let json = try? JSON(data: data) else { return }
            
            let view = json["view"].arrayValue.map({$0.stringValue})
            
            let items = self?.parseJSON(json: json)
            
            completion((items,view))
            
        }.resume()
        
    }
    
    private func parseJSON(json: JSON)->[AnotherItemBase]{
        var variantsForSelector: [(text: String?,id: Int?)] = []
        
        let names = json["data"].arrayValue.map({$0["name"].stringValue})
        
        let dataForItems = json["data"].arrayValue.map({$0["data"].dictionary})
        
        let dataHZ = dataForItems[0]?["text"]?.stringValue
        
        let urlForImage: String? = dataForItems[1]?["url"]?.stringValue
        guard let url = URL(string: urlForImage ?? "") else {return []}
        let baseData = try? Data(contentsOf: url)
        let dataForImage = (dataForItems[1]?["text"]?.stringValue,baseData)
        
        let selectedID = dataForItems[2]?["selectedId"]?.int
        
        let selectedItems = dataForItems[2]?["variants"]?.arrayValue.map({$0.dictionary})
        
        variantsForSelector.append((selectedItems?[0]?["text"]?.string, selectedItems?[0]?["id"]?.int))
        variantsForSelector.append((selectedItems?[1]?["text"]?.string, selectedItems?[1]?["id"]?.int))
        variantsForSelector.append((selectedItems?[2]?["text"]?.string, selectedItems?[2]?["id"]?.int))
        
        return [Label(name: names[0], data: dataHZ),
                Image(name: names[1], data: dataForImage),
                Selector(name: names[2], data: variantsForSelector, selectedID: selectedID)]
    }
}
