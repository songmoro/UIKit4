//
//  Designable.swift
//  UIKit4
//
//  Created by 송재훈 on 7/22/25.
//

import UIKit

protocol Designable {
    
}

extension Designable where Self: UIViewController {
    func needsAddSubview(views: UIView...) {
        views.forEach {
            view.addSubview($0)
        }
    }
    
    func needsAutoresizingMaskFalse(views: UIView...) {
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}
