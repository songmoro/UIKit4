//
//  AuthenticationViewController.swift
//  UIKit4
//
//  Created by 송재훈 on 7/23/25.
//

import UIKit
import SnapKit

class AuthenticationViewController: UIViewController {
    let emailTextField: UITextField = FilledTextField(backgroundColor: .systemRed, placeholder: "이메일")
    let passwordTextField: UITextField = FilledTextField(backgroundColor: .systemBlue, placeholder: "비밀번호")
    let ageTextField: UITextField = FilledTextField(backgroundColor: .systemBrown, placeholder: "나이")
    
    let picker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .wheels
        
        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureLayout()
        configurePicker()
    }
}

extension AuthenticationViewController: Designable {
    func configure() {
        view.backgroundColor = .systemBackground
        
        view.addSubviews(emailTextField, passwordTextField, ageTextField)
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
        
        ageTextField.snp.makeConstraints {
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.top.equalTo(passwordTextField.snp.bottom).offset(20)
            $0.height.equalTo(44)
        }
    }
}

// MARK: Picker
extension AuthenticationViewController {
    func configurePicker() {
        picker.addTarget(self, action: #selector(agePickerValueChanged), for: .valueChanged)
        ageTextField.inputView = picker
    }
    
    @objc func agePickerValueChanged(_ sender: UIDatePicker) {
        print(#function, sender)
    }
}
