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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI(model: PropertyModel) {
        self.addr1Label.text = model.addr
        self.addr2Label.text = "\(model.city), \(model.state) \(model.zip)"
    }

}
