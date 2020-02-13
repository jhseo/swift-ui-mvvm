//
//  APIService.swift
//  swift-ui-mvvm
//
//  Created by jhseo on 2020/02/06.
//  Copyright © 2020 jhseo. All rights reserved.
//

import SwiftUI
import Combine

final class APIService {
    private static let baseURL: String = "https://www.googleapis.com/books/v1/volumes"

    static func searchBook(searchText: String, startIndex: Int, maxResults: Int) -> AnyPublisher<BookModel?, Never> {
        var urlComponents = URLComponents(string: baseURL)!
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: searchText),
            URLQueryItem(name: "startIndex", value: String(startIndex)),
            URLQueryItem(name: "maxResults", value: String(maxResults))
        ]
        var request = URLRequest(url: urlComponents.url!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        return URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: BookModel.self, decoder: JSONDecoder())
            .map { $0 }
            .replaceError(with: nil)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher() // Publisher 타입을 AnyPublisher로 변경 (Cancellable을 사용하기 위함)
    }
}
