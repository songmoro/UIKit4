//
//  BookViewContoller.swift
//  UIKit4
//
//  Created by 송재훈 on 7/25/25.
//

import UIKit
import SnapKit

class BookViewContoller: UIViewController {
    var item = BookResponse(items: []).items
    var item2: [KakaoBookResponse.Document] = []
    var meta = KakaoBookResponse.Meta(is_end: false, pageable_count: 0, total_count: 0)
    var page = 1
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        
        return searchBar
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.keyboardDismissMode = .interactive
        tableView.register(BookCell.self)
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

extension BookViewContoller: Designable {
    func configure() {
        view.backgroundColor = .systemBackground
        view.addSubviews(tableView, searchBar)
        
        [searchBar, tableView].snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview(\.safeAreaLayoutGuide)
        }
        
        searchBar.snp.makeConstraints {
            $0.top.equalToSuperview(\.safeAreaLayoutGuide)
            $0.height.equalTo(44)
        }
        
        tableView.snp.makeConstraints {
            $0.bottom.equalToSuperview(\.safeAreaLayoutGuide)
            $0.top.equalTo(searchBar.snp.bottom)
        }
    }
}

extension BookViewContoller: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        requestKakao(text)
    }
}

extension BookViewContoller: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        item2.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(BookCell.self, for: indexPath)
        
        if let cell = cell as? BookCell {
//            let row = item2[indexPath.row]
//            cell.titleLabel.text = row.title
//            cell.thumbnailImageView.image = UIImage
//            cell.subTitleLabel.text = "\(row.author) 작가(\(row.pubdate))"
//            cell.overviewLabel.text = row.description
            
            let row = item2[indexPath.row]
            cell.titleLabel.text = row.title
            cell.subTitleLabel.text = "\(row.authors.description) 작가(\(row.datetime))"
            cell.overviewLabel.text = row.contents
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if !meta.is_end, indexPath.row == (item2.count - 3) {
            page += 1
            requestKakao(searchBar.text!)
        }
    }
    
    func requestKakao(_ text: String) {
        NetworkAPI.book(query: text, page: page, size: 20).call(of: KakaoBookResponse.self) {
            switch $0 {
            case .success(let book):
                self.item2.append(contentsOf: book.documents)
                self.meta = book.meta
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

struct KakaoBookResponse: Decodable {
    let documents: [Document]
    let meta: Meta
    
    struct Document: Decodable {
        let authors: [String]
        let contents: String
        let datetime: String
        let isbn: String
        let price: Int
        let publisher: String
        let sale_price: Int
        let status: String
        let thumbnail: String
        let title: String
        let translators: [String]
        let url: String
    }

    struct Meta: Decodable {
        let is_end: Bool
        let pageable_count: Int
        let total_count: Int
    }
}

#if DEBUG
#Preview {
    BookViewContoller()
}
#endif
