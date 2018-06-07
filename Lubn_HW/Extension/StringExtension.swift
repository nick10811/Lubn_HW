//
//  StringExtension.swift
//  Lubn_HW
//
//  Created by Nick Yang on 2018/6/7.
//  Copyright © 2018 Nick Yang. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func getPlaceholderAttribute() -> NSAttributedString {
        return NSAttributedString(string: self, attributes:[NSAttributedStringKey.foregroundColor: UIColor.textFieldColor()])
        
    }
}
