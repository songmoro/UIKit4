//
//  BookViewContoller.swift
//  UIKit4
//
//  Created by 송재훈 on 7/25/25.
//

import UIKit
import Alamofire
import SnapKit

struct Book: Decodable {
    let market: String
    let korean_name: String
    let english_name: String
    
    var labelText: String {
        "\(market) | \(korean_name)(\(english_name)"
    }
}

class BookViewContoller: UIViewController {
    var items: [Book] = []
    
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

extension BookViewContoller: Designable {
    func configure() {
        view.backgroundColor = .systemBackground
    }
}

extension BookViewContoller: UITableViewDelegate, UITableViewDataSource {
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
            .responseDecodable(of: [Book].self) {
                switch $0.result {
                case .success(let book):
                    self.items = book
                    self.tableView.reloadData()
                default:
                    break
                }
            }
    }
}

#if DEBUG
#Preview {
    BookViewContoller()
}
#endif
