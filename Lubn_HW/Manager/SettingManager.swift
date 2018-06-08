//
//  SettingManager.swift
//  Lubn_HW
//
//  Created by Nick Yang on 2018/6/8.
//  Copyright © 2018 Nick Yang. All rights reserved.
//

import Foundation

class SettingManager{
    private static var instance: SettingManager?
    static func sharedInstance() -> SettingManager {
        if instance == nil {
            instance = SettingManager()
        }
        return instance!
    }
    
    let defaults = UserDefaults.standard
    
    func save(_ strVal:String, forKey key:String){
        defaults.setValue(strVal, forKey: key)
    }
    
    func load(_ key:String)->String?{
        return defaults.value(forKey: key) as? String
    }
    
    func saveObject(_ object:AnyObject, forKey key:String){
        defaults.set(object, forKey: key)
    }
    
    func loadObject(_ key:String) -> AnyObject? {
        return defaults.object(forKey: key) as AnyObject?
    }
    
    func remove(forKey key: String) {
        defaults.removeObject(forKey: key)
    }
    
}
