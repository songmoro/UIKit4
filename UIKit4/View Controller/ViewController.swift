//
//  ViewController.swift
//  UIKit4
//
//  Created by 송재훈 on 7/21/25.
//

import UIKit

struct BMI {
    let height: Double
    let weight: Double
    
    var result: String {
        get {
            let value = weight / (height * height)
            
            if value < 18.5 {
                return "저체중"
            }
            else {
                return "정상"
            }
        }
    }
}

class ViewController: UIViewController {
    @IBOutlet var heightTextField: UITextField!
    @IBOutlet var weightTextField: UITextField!
    @IBOutlet var verifyButton: UIButton!
    
    var bmi = BMI(height: 180, weight: 180)
    var userdefaults = UserDefaultsHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        verifyButton.addTarget(self, action: #selector(verify), for: .touchUpInside)
    }
    
//    let textField: UITextField = {
//        let textField = UITextField()
//        textField.backgroundColor = .red
//        
//        return textField
//    }()
//    
//    let scrollView: UIScrollView = {
//        let scrollView = UIScrollView()
//        scrollView.backgroundColor = .blue
//        
//        return scrollView
//    }()
//    
//    let contentView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .brown
//        
//        return view
//    }()
//    
//    
//    func configureScrollableView() {
//        scrollView.addSubview(contentView)
//        contentView.addSubview(textField)
//        
//        view.addSubview(scrollView)
//        
//        scrollView.keyboardDismissMode = .interactive
//        scrollView.snp.makeConstraints {
//            $0.top.equalTo(weightTextField.snp.bottom).offset(200)
//            $0.leading.trailing.equalToSuperview()
//            $0.height.equalTo(100)
//        }
//        
//        contentView.snp.makeConstraints {
//            $0.edges.equalTo(scrollView.contentLayoutGuide)
//            $0.width.equalTo(scrollView.frameLayoutGuide)
//            $0.height.equalTo(101)
//        }
//        
//        textField.snp.makeConstraints {
//            $0.centerX.centerX.equalToSuperview()
//            $0.width.equalToSuperview()
//            $0.height.equalTo(100)
//        }
//        
//        scrollView.bounces = false
//    }
    
    @objc func verify(_ sender: UIButton) {
        let vc = KeyboardDismissViewController()
//        let vc = MarketViewController()
        navigationController?.pushViewController(vc, animated: true)
        
//        guard let height = heightTextField.text, height.count > 2 else {
//            print("height 입력 오류")
//            return
//        }
//        guard let weight = weightTextField.text, weight.count > 2 else {
//            print("weight 입력 오류")
//            return
//        }
//        
//        print(height, weight)
    }
}
