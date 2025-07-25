//
//  Coin.swift
//  UIKit4
//
//  Created by 송재훈 on 7/25/25.
//

struct Coin: Decodable {
    let market: String
    let korean_name: String
    let english_name: String
    
    var labelText: String {
        "\(market) | \(korean_name)(\(english_name)"
    }
}
