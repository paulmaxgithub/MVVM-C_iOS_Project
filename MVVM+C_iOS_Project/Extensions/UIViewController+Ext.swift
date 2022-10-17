//
//  UIViewController+Ext.swift
//  MVVM+C_iOS_Project
//
//  Created by PaulmaX on 17.10.22.
//

import UIKit

extension UIViewController {
    
    static func instantiate<T>() -> T {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        return storyboard.instantiateViewController(withIdentifier: "\(T.self)") as! T
    }
}
