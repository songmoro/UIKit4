//
//  KeyboardDismissViewController.swift
//  UIKit4
//
//  Created by 송재훈 on 7/23/25.
//

import UIKit
import SnapKit

class KeyboardDismissViewController: UIViewController {
    let tableView: UITableView = {
        let tableView = UITableView()
        
        return tableView
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        
        
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        configureTableView()
        configureTextField()
    }
}

extension KeyboardDismissViewController: Designable {
    func configure() {
        view.backgroundColor = .systemBackground
        view.addSubviews(tableView, textField)
    }
}

extension KeyboardDismissViewController: UITextFieldDelegate {
    func configureTextField() {
        textField.delegate = self
        textField.borderStyle = .bezel
        
        textField.snp.makeConstraints {
            $0.top.equalTo(tableView.snp.bottom)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(40)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
}

extension KeyboardDismissViewController: UITableViewDelegate, UITableViewDataSource {
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 40
        tableView.keyboardDismissMode = .onDrag
        
        tableView.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let uiView = UIView()
        
        cell.addSubview(uiView)
        uiView.layer.borderColor = UIColor.black.cgColor
        uiView.layer.borderWidth = 1
        
        uiView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        let colors: [UIColor] = [
            .systemRed,
            .systemOrange,
            .systemYellow,
            .systemTeal,
            .systemGreen,
            .systemPink,
            .systemPurple,
            .systemBlue,
            .systemCyan
        ]
        uiView.backgroundColor = colors.randomElement()!
        
        return cell
    }
}
