//
//  ResultViewController.swift
//  UIKit4
//
//  Created by 송재훈 on 7/21/25.
//

import UIKit
import SnapKit

class ResultViewController: UIViewController {
    let resultLabel = UILabel()
    let redView = UIView()
    let blackView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(resultLabel)
        view.addSubview(redView)
        view.addSubview(blackView)
        redView.backgroundColor = .systemRed
        
        resultLabel.text = "12321321321"
        redView.snp.makeConstraints {
            $0
                .top
                .leading
                .trailing
                .equalTo(view.safeAreaLayoutGuide).inset(20)
            
            $0.height.equalTo(40)
        }
    }
    
    func autolayoutBasedLayout() {
        view.addSubview(resultLabel)
        view.addSubview(redView)
        view.addSubview(blackView)
        
        resultLabel.text = "1321412412"
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        blackView.translatesAutoresizingMaskIntoConstraints = false
        redView.translatesAutoresizingMaskIntoConstraints = false
        
//        NSLayoutConstraint(
//            item: resultLabel,
//            attribute: .leading,
//            relatedBy: .equal,
//            toItem: view,
//            attribute: .leading,
//            multiplier: 1,
//            constant: 20
//        ).isActive = true
//
//        NSLayoutConstraint(
//            item: resultLabel,
//            attribute: .trailing,
//            relatedBy: .equal,
//            toItem: view,
//            attribute: .trailing,
//            multiplier: 1,
//            constant: -20
//        ).isActive = true
//
//        NSLayoutConstraint(
//            item: resultLabel,
//            attribute: .bottom,
//            relatedBy: .equal,
//            toItem: view.safeAreaLayoutGuide,
//            attribute: .bottom,
//            multiplier: 1,
//            constant: -20
//        ).isActive = true
//
//        NSLayoutConstraint(
//            item: resultLabel,
//            attribute: .height,
//            relatedBy: .equal,
//            toItem: nil,
//            attribute: .height,
//            multiplier: 1,
//            constant: 50
//        ).isActive = true
        
        NSLayoutConstraint.activate([
            blackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            blackView.trailingAnchor.constraint(equalTo: redView.leadingAnchor),
            blackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            blackView.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        NSLayoutConstraint.activate([
            redView.leadingAnchor.constraint(equalTo: blackView.trailingAnchor),
            redView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            redView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            redView.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        redView.backgroundColor = .systemRed
        blackView.backgroundColor = .systemGreen
        resultLabel.backgroundColor = .systemGreen.withAlphaComponent(0.5)
        view.layer.borderColor = UIColor.blue.cgColor
        view.layer.borderWidth = 2
    }
    
    func frameBasedLayout() {
        view.addSubview(resultLabel)
        view.addSubview(redView)
        redView.addSubview(blackView)
        
        resultLabel.text = "12312312"
        resultLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 44)
        redView.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        blackView.frame  = CGRect(x: 50, y: 50, width: 100, height: 100)
        
        redView.backgroundColor = .systemRed
        blackView.backgroundColor = .label
        redView.clipsToBounds = true
    }
}
