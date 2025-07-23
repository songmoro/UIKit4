//
//  MarketViewController.swift
//  UIKit4
//
//  Created by 송재훈 on 7/23/25.
//

import UIKit
import SnapKit

class MarketViewController: UIViewController {
    let tableView: UITableView = {
        let tableView = UITableView()
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureTableView()
    }
}

extension MarketViewController: Designable {
    func configure() {
        view.backgroundColor = .systemBackground
    }
}

extension MarketViewController: UITableViewDelegate, UITableViewDataSource {
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        return cell
    }
}
