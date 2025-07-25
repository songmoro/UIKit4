//
//  BookCell.swift
//  UIKit4
//
//  Created by 송재훈 on 7/25/25.
//

import UIKit
import SnapKit

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
