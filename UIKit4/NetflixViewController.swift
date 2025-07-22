//
//  NetflixViewController.swift
//  UIKit4
//
//  Created by 송재훈 on 7/21/25.
//

import UIKit
import SnapKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}

extension UIStackView {
    func addArrangedSubviews(_ view: UIView...) {
        for view in view {
            addArrangedSubview(view)
        }
    }
}

class NetflixViewController: UIViewController {
    let titleLabel = UILabel()
    let stackView = UIStackView()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let nicknameTextField = UITextField()
    let locationTextField = UITextField()
    let referralTextField = UITextField()
    let registerButton = UIButton()
    let additionalStackView = UIStackView()
    let additionalLabel = UILabel()
    let additionalSwitch = UISwitch()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
}

extension NetflixViewController {
    func configureView() {
        view.backgroundColor = .black
        view.addSubviews(titleLabel, stackView)
        
        configureTitleLabel()
        configureStackView()
        configureTextFields()
        configureRegisterButton()
        configureAdditional()
    }
    
    func configureTitleLabel() {
        let attributedText = NSAttributedString(string: "Netflix", attributes: [.foregroundColor: UIColor.systemRed, .font: UIFont.systemFont(ofSize: 40, weight: .black)])
        titleLabel.attributedText = attributedText
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.centerX.equalTo(view)
        }
    }
    
    func configureStackView() {
        for view in [emailTextField, passwordTextField, nicknameTextField, locationTextField, referralTextField, registerButton, additionalStackView] {
            stackView.addArrangedSubview(view)
            view.layer.cornerRadius = 4
            
            view.snp.makeConstraints {
                $0.horizontalEdges.equalToSuperview()
            }
        }
        
        stackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(40)
            $0.height.lessThanOrEqualTo(400)
        }
        
        stackView.spacing = 16
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
    }
    
    func configureTextFields() {
        configureTextField(emailTextField, placeholder: "이메일 주소 또는 전화번호")
        configureTextField(passwordTextField, placeholder: "비밀번호")
        configureTextField(nicknameTextField, placeholder: "닉네임")
        configureTextField(locationTextField, placeholder: "위치")
        configureTextField(referralTextField, placeholder: "추천 코드 입력")
    }
    
    func configureTextField(_ textField: UITextField, placeholder: String) {
        let attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor.white])
        
        textField.attributedPlaceholder = attributedPlaceholder
        textField.backgroundColor = .darkGray
        textField.textAlignment = .center
        textField.snp.makeConstraints {
            $0.height.equalTo(36)
        }
    }
    
    func configureRegisterButton() {
        let attributedText = NSAttributedString(string: "회원가입", attributes: [.foregroundColor: UIColor.black, .font: UIFont.systemFont(ofSize: 16, weight: .bold)])
        
        registerButton.snp.makeConstraints {
            $0.height.equalTo(44)
        }
        registerButton.setAttributedTitle(attributedText, for: .normal)
        registerButton.setTitleColor(.black, for: .normal)
        registerButton.backgroundColor = .white
    }
    
    func configureAdditional() {
        additionalStackView.addArrangedSubviews(additionalLabel, additionalSwitch)
        additionalStackView.axis = .horizontal
        additionalStackView.alignment = .center
        additionalStackView.snp.makeConstraints {
            $0.height.equalTo(40)
        }
        
        additionalLabel.text = "추가 정보 입력"
        additionalLabel.textColor = .white
        additionalLabel.snp.makeConstraints {
            $0.height.equalToSuperview()
        }
        
        additionalSwitch.onTintColor = .systemRed
        additionalSwitch.isOn = true
    }
}
