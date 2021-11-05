//
//  SearchBook.swift
//  Sendbird_iOS
//
//  Created by 엄기영 on 2021/10/28.
//

import Foundation

// MARK: - SearchData
struct SearchData: Codable {
    let error, total, page: String
    var books: [Book]
}

// MARK: - Book
struct Book: Codable {
    let title, subtitle, isbn13, price: String
    let image: String
    let url: String
}

