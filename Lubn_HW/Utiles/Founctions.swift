//
//  Founctions.swift
//  Lubn_HW
//
//  Created by Nick Yang on 2018/6/7.
//  Copyright © 2018 Nick Yang. All rights reserved.
//

import Foundation
import UIKit

func findViewControllerByIdFromStoryboard(_ storyboardName:String,viewControllerId: String) -> UIViewController {
    
    let storyboard = UIStoryboard(name: storyboardName,bundle:nil)
    return storyboard.instantiateViewController(withIdentifier: viewControllerId) as UIViewController
}

enum LogLevel {
    case debug
    case info
    case warning
    case error
}

func printLog<T>(_ level: LogLevel, _ message: T, file: String = #file, line: Int = #line, method: String = #function) {
    #if DEBUG
        var levelStr = ""
        switch level {
        case .debug:
            levelStr = "[DEBUG]"
        case .info:
            levelStr = "[INFO]"
        case .warning:
            levelStr = "[WARNING]"
        case .error:
            levelStr = "[ERROR]"
        }
        
        print("\(levelStr) \((file as NSString).lastPathComponent):\(line), \(method): \(message)")
    #endif
}

/// Configure Button:
/// Image on the top, Title on the bottom (+10pt)
///
/// - parameter button:        UIButton
///
func configureMenuButton(button: UIButton){
    button.imageEdgeInsets = UIEdgeInsetsMake(-(button.titleLabel?.intrinsicContentSize.height)!, 0, 0, -(button.titleLabel?.intrinsicContentSize.width)!)
    if button.currentImage != nil {
        button.titleEdgeInsets = UIEdgeInsetsMake((button.currentImage?.size.height)!+10, -(button.currentImage?.size.width)!, 0, 0)
    }
}
