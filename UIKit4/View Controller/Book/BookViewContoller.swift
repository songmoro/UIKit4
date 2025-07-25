//
//  BookViewContoller.swift
//  UIKit4
//
//  Created by 송재훈 on 7/25/25.
//

import UIKit
import Alamofire
import SnapKit

struct BookResponse: Decodable {
    let items: [BookItem]
}

struct BookItem: Decodable {
    let title: String
    let link: String
    let image: String
    let author: String
    let pubdate: String
    let description: String
}

class BookCell: UITableViewCell, IsIdentifiable {
    let thumbnailImageView = UIImageView()
    let titleLabel = UILabel()
    let subTitleLabel = UILabel()
    let overviewLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() {
        contentView.addSubviews(thumbnailImageView, titleLabel, subTitleLabel, overviewLabel)
    }
    
    func configureLayout() {
        [titleLabel, subTitleLabel, overviewLabel].snp.makeConstraints {
            $0.leading.equalTo(thumbnailImageView.snp.trailing).offset(8)
            $0.trailing.equalToSuperview(\.safeAreaLayoutGuide).inset(16)
        }
        
        [titleLabel, subTitleLabel].snp.makeConstraints {
            $0.height.equalTo(18)
        }
        
        [thumbnailImageView, overviewLabel].snp.makeConstraints {
            $0.bottom.equalToSuperview(\.safeAreaLayoutGuide).inset(16)
        }
        
        [thumbnailImageView, titleLabel].snp.makeConstraints {
            $0.top.equalToSuperview(\.safeAreaLayoutGuide).inset(16)
        }
        
        thumbnailImageView.snp.makeConstraints {
            $0.leading.equalToSuperview(\.safeAreaLayoutGuide).inset(16)
            $0.width.equalTo(80)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
        }
        
        overviewLabel.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom)
        }
    }
    
    func configureView() {
        thumbnailImageView.contentMode = .scaleAspectFill
        overviewLabel.numberOfLines = 0
        overviewLabel.font = .systemFont(ofSize: 13)
    }
}

class BookViewContoller: UIViewController {
    var item = BookResponse(items: []).items
    
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
        request(text)
    }
}

extension BookViewContoller: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        item.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(BookCell.self, for: indexPath)
        
        if let cell = cell as? BookCell {
            let row = item[indexPath.row]
            cell.titleLabel.text = row.title
//            cell.thumbnailImageView.image = UIImage
            cell.subTitleLabel.text = "\(row.author) 작가(\(row.pubdate))"
            cell.overviewLabel.text = row.description
        }
        
        return cell
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
}

#if DEBUG
#Preview {
    BookViewContoller()
}
#endif
