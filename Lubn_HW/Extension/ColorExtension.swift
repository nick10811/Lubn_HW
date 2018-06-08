//
//  ColorExtension.swift
//  Lubn_HW
//
//  Created by Nick Yang on 2018/6/7.
//  Copyright © 2018 Nick Yang. All rights reserved.
//

import UIKit

extension UIColor {
    class func textFieldColor() -> UIColor {
        return UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.4)
    }
    
    class func statusBarColor() -> UIColor {
        return UIColor(red: 0/255, green: 141/255, blue: 223/255, alpha: 1.0)
    }
    
    class func fontGray1() -> UIColor {
        return UIColor(red: 140/255, green: 140/255, blue: 140/255, alpha: 1.0)
    }
    
    class func fontGray2() -> UIColor {
        return UIColor(red: 109/255, green: 109/255, blue: 114/255, alpha: 1.0)
    }
}
