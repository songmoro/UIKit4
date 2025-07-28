//
//  BookViewContoller.swift
//  UIKit4
//
//  Created by 송재훈 on 7/25/25.
//

import UIKit
import Alamofire
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
    
    func request(_ text: String) {
        let url = URL(string: "https://openapi.naver.com/v1/search/book.json?query=\(text)&display=100")!
        let header = HTTPHeaders([
            "X-Naver-Client-Id": APIKey.naverClientId,
            "X-Naver-Client-Secret": APIKey.naverClientSecret
        ])
        
        AF.request(url, method: .get, headers: header)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: BookResponse.self) {
                switch $0.result {
                case .success(let book):
                    self.item = book.items
                    self.tableView.reloadData()
                default:
                    break
                }
            }
    }
    
    func requestKakao(_ text: String) {
        let url = URL(string: "https://dapi.kakao.com/v3/search/book?query=\(text)&size=20&page=\(page)")!
        let header = HTTPHeaders([
            "Authorization": APIKey.kakaoAuthorization
        ])
        
        AF.request(url, method: .get, headers: header)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: KakaoBookResponse.self) {
                switch $0.result {
                case .success(let book):
                    self.item2.append(contentsOf: book.documents)
                    self.meta = book.meta
                    self.tableView.reloadData()
                default:
                    break
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
