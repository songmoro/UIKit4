//
//  MarketViewController.swift
//  UIKit4
//
//  Created by 송재훈 on 7/23/25.
//

import UIKit
import SnapKit
import Alamofire

class MarketViewController: UIViewController {
    var items: [Coin] = []
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MarketCell.self)
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureTableView()
        request()
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
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(MarketCell.self, for: indexPath)
        
        if let cell = cell as? MarketCell {
            let item = items[indexPath.row]
            cell.nameLabel.text = item.labelText
        }
        
        return cell
    }
    
    func request() {
        let url = URL(string: "https://api.upbit.com/v1/market/all")!
        
        AF.request(url, method: .get)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: [Coin].self) {
                switch $0.result {
                case .success(let coins):
                    self.items = coins
                    self.tableView.reloadData()
                default:
                    break
                }
            }
    }
}

#if DEBUG
#Preview {
    MarketViewController()
}
#endif
