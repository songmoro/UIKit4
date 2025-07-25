//
//  BookResponse.swift
//  UIKit4
//
//  Created by 송재훈 on 7/25/25.
//

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
