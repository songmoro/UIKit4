//
//  MarketCell.swift
//  UIKit4
//
//  Created by 송재훈 on 7/23/25.
//

import UIKit
import SnapKit

class MarketCell: UITableViewCell {
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "레이블"
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MarketCell {
    func configure() {
        contentView.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}

extension MarketCell: IsIdentifiable {
    
}
