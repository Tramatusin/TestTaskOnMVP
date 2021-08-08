//
//  TableViewCellForItem.swift
//  MVVMExample
//
//  Created by Виктор Поволоцкий on 07.08.2021.
//

import UIKit

class TableViewCellForItem: UITableViewCell {
    
    static let tableViewCellId = "cellID"
    
    lazy var labelForTypeItem: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(text: String){
        labelForTypeItem.text = text
    }

    func setupConstraint(){
        contentView.addSubview(labelForTypeItem)
        
        NSLayoutConstraint.activate([
            labelForTypeItem.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            labelForTypeItem.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            labelForTypeItem.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    override func layoutSubviews() {
            super.layoutSubviews()
            let margins = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
            contentView.frame = contentView.frame.inset(by: margins)
            contentView.layer.cornerRadius = 10
            contentView.backgroundColor = .orange
            setupConstraint()
        }
}
