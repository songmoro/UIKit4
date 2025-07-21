//
//  ViewController.swift
//  UIKit4
//
//  Created by 송재훈 on 7/21/25.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var heightTextField: UITextField!
    @IBOutlet var weightTextField: UITextField!
    @IBOutlet var verifyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        verifyButton.addTarget(self, action: #selector(verify), for: .touchUpInside)
    }
    
    @objc func verify(_ sender: UIButton) {
        let vc = ResultViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
