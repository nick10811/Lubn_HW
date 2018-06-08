//
//  propertyCell.swift
//  Lubn_HW
//
//  Created by Nick Yang on 2018/6/7.
//  Copyright © 2018 Nick Yang. All rights reserved.
//

import UIKit

class PropertyCell: UITableViewCell {
    @IBOutlet weak var addr1Label: UILabel!
    @IBOutlet weak var addr2Label: UILabel!
    @IBOutlet weak var editButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupUI(model: PropertyModel) {
        if model.isSelected {
            self.selectedCell()
        } else {
            self.deselectedCell()
        }
        
        self.addr1Label.text = model.addr
        self.addr2Label.text = "\(model.city), \(model.state) \(model.zip)"
    }
    
    func deselectedCell() {
        self.backgroundColor = .clear
        self.editButton.isHidden = true
        self.addr1Label.textColor = .white
        self.addr2Label.textColor = UIColor.fontGray1()
    }
    
    func selectedCell() {
        self.backgroundColor = .white
        self.editButton.isHidden = false
        self.addr1Label.textColor = .black
        self.addr2Label.textColor = UIColor.fontGray2()
    }

}
