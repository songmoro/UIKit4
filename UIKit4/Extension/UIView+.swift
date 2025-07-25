//
//  UIView+.swift
//  UIKit4
//
//  Created by 송재훈 on 7/23/25.
//

import UIKit

extension UIView {
    func addSubviews(views: UIView...) {
        views.forEach {
            self.addSubview($0)
        }
    }
}
