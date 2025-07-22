//
//  UserDefaultsHelper.swift
//  UIKit4
//
//  Created by 송재훈 on 7/22/25.
//


struct UserDefaultsHelper {
    var age: Int {
        get {
            UserDefaults.standard.integer(forKey: "age")
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "age")
        }
    }
    
    var storedAge: Int = UserDefaults.standard.integer(forKey: "age")
}