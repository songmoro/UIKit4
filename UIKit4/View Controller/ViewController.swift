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
