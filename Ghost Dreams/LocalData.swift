//
//  LocalData.swift
//  Magical Kenya
//
//  Created by Morris Mwangi on 25/03/2018.
//  Copyright © 2018 Morris Mwangi. All rights reserved.
//

import Foundation

class LocalData: NSObject {
    
    class func addData (name : String, value : String) {
        
        UserDefaults.standard.set(value, forKey: name)
        //NSUserDefaults.standardUserDefaults().synchronize() //Not a must for iOS 8
        
    }
    
    class func getData (name : String ) -> String {
        var result : String = ""
        
        if (UserDefaults.standard.object(forKey: name) as? String) != nil {
            
            result = (UserDefaults.standard.object(forKey: name)! as? String)!
        }
        
        return result
    }
    
    class func removeData (name : String) {
        
        if (UserDefaults.standard.object(forKey: name) as? String) != nil {
            
            UserDefaults.standard.removeObject(forKey: name)
        }
        
    }
    
    class func checkData (name : String) -> Bool {
        var result : Bool = false
        
        if (UserDefaults.standard.object(forKey: name) as? String) != nil {
            
            result = true
        }
        
        return result
    }
    
}
