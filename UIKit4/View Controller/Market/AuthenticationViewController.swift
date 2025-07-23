//
//  AuthenticationViewController.swift
//  UIKit4
//
//  Created by 송재훈 on 7/23/25.
//

import UIKit
import SnapKit

class AuthenticationViewController: UIViewController {
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemRed
        
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemBlue
        
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureLayout()
    }
}

extension AuthenticationViewController: Designable {
    func configure() {
        view.backgroundColor = .systemBackground
        
        view.addSubviews(emailTextField, passwordTextField)
    }
    
    func configureLayout() {
        emailTextField.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(44)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.top.equalTo(emailTextField.snp.bottom).offset(20)
            $0.height.equalTo(44)
        }
    }
}
