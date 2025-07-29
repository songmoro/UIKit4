//
//  NetworkAPI.swift
//  UIKit4
//
//  Created by 송재훈 on 7/29/25.
//

import Foundation
import Alamofire

enum NetworkErrorReason: Error {
    case dataIsNil
    case responseIsNil
    case statusError
    case decodeError
}

enum NetworkAPI {
    case market
    case book(query: String, page: Int, size: Int)
}

extension NetworkAPI {
    var url: URL {
        switch self {
        case .market: URL(string: "https://api.upbit.com/v1/market/all")!
        case .book(let query, let page, let size): URL(string: "https://dapi.kakao.com/v3/search/book?query=\(query)&page=\(page)&size=\(size)")!
        }
    }
    
    var method: HTTPMethod {
        switch self {
        default: .get
        }
    }
    
    var header: HTTPHeaders? {
        switch self {
        case .market: nil
        case .book: HTTPHeaders(["Authorization": APIKey.kakaoAuthorization])
        }
    }
}

extension NetworkAPI {
    func call<Value>(of type: Value.Type = Value.self, handler: @escaping (Result<Value, Error>) -> Void) where Value: Decodable {
        AF.request(url, method: method, headers: header)
            .response {
                switch $0.result {
                case .success(let data):
                    guard let data else { handler(.failure(NetworkErrorReason.dataIsNil)); return }
                    guard let response = $0.response else { handler(.failure(NetworkErrorReason.responseIsNil)); return }
                    guard 200..<300 ~= response.statusCode else { handler(.failure(NetworkErrorReason.statusError)); return }
                    guard let value = try? JSONDecoder().decode(type.self, from: data) else { handler(.failure(NetworkErrorReason.decodeError)); return }
                    handler(.success(value))
                    
                case .failure(let error):
                    handler(.failure(error))
                }
            }
    }
}
