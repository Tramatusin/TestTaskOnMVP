//
//  ViewForItems.swift
//  MVVMExample
//
//  Created by Виктор Поволоцкий on 07.08.2021.
//

import Foundation
import UIKit

class ViewForItems: UIView{
    
    var viewData: String = "hz" {
        didSet{
            setNeedsLayout()
        }
    }
    
    var labelData: Label?
    var imageData: Image?
    var selectorData: Selector?
    
    lazy var image: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var labelForImage: UILabel = {
        let label = UILabel()
        label.clipsToBounds = true
        label.layer.cornerRadius = 15
        label.layer.borderWidth = 1.0
        label.layer.borderColor = UIColor.black.cgColor
        label.textAlignment = .center
        label.backgroundColor = .systemOrange
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.clipsToBounds = true
        label.layer.cornerRadius = 15
        label.layer.borderWidth = 1.0
        label.layer.borderColor = UIColor.black.cgColor
        label.textAlignment = .center
        label.backgroundColor = .systemOrange
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var selector: UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: ["one","two","three"])
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.addTarget(self, action: #selector(changeValueSegment), for: .valueChanged)
        return segmentControl
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.backgroundColor = .white
        setupConstraint()
        setupData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupData(){
        guard let dataImage = imageData?.data.urldata else {return}
        label.text = labelData?.data
        labelForImage.text = imageData?.data.text
        image.image = UIImage(data: dataImage)
    }
    
    func setupConstraint(){
        self.addSubview(image)
        self.addSubview(label)
        self.addSubview(labelForImage)
        self.addSubview(selector)
        
        NSLayoutConstraint.activate([
            image.centerYAnchor.constraint(equalTo:self.centerYAnchor),
            image.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            image.widthAnchor.constraint(equalToConstant: 100),
            image.heightAnchor.constraint(equalTo: image.widthAnchor),
            
            labelForImage.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 4),
            labelForImage.leftAnchor.constraint(equalTo: image.leftAnchor),
            labelForImage.rightAnchor.constraint(equalTo: image.rightAnchor),
            labelForImage.heightAnchor.constraint(equalToConstant: 40),
            
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.heightAnchor.constraint(equalToConstant: 40),
            label.widthAnchor.constraint(equalToConstant: 150),
            
            selector.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            selector.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            selector.widthAnchor.constraint(equalToConstant: 200),
            selector.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc
    func changeValueSegment(target: UISegmentedControl){
        guard let selectID = selectorData?.SelectedID else {return}
        guard let curVariant = selectorData?.data[target.selectedSegmentIndex].descript, let curVariantId = selectorData?.data[target.selectedSegmentIndex].id else {return}
        print("SelectedID: \(selectID), \(curVariant) id:\(curVariantId)")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        switch viewData {
        case "selector":
            image.isHidden = true
            label.isHidden = true
            selector.isHidden = false
            labelForImage.isHidden = true
        case "picture":
            image.isHidden = false
            labelForImage.isHidden = false
            label.isHidden = true
            selector.isHidden = true
        case "hz":
            image.isHidden = true
            label.isHidden = false
            selector.isHidden = true
            labelForImage.isHidden = true
        default:
            print("it's a very strange")
        }
        
    }
}
