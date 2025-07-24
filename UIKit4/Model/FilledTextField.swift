//
//  FilledTextField.swift
//  UIKit4
//
//  Created by 송재훈 on 7/24/25.
//

import UIKit

class FilledTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(backgroundColor: UIColor, placeholder: String) {
        self.init(backgroundColor: backgroundColor)
        self.placeholder = placeholder
    }
    
    init(backgroundColor: UIColor) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
