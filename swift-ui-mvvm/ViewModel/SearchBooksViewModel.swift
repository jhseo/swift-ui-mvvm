//
//  SearchBooksViewModel.swift
//  swift-ui-mvvm
//
//  Created by jhseo on 2020/02/06.
//  Copyright © 2020 jhseo. All rights reserved.
//

import SwiftUI
import Combine

final class SearchBooksViewModel: ObservableObject {
    private var cancellable: AnyCancellable? = nil
    private var startIndex: Int = 0
    private let maxResults: Int = 20
    var shouldInfiniteScroll: Bool = true

    var searchText: String = "" {
        didSet {
            startIndex = 0
            shouldInfiniteScroll = true
            books = nil
            search()
        }
    }

    @Published private(set) var books: BookModel?

    private func search() {
        guard shouldInfiniteScroll else { return }
        cancellable = APIService.searchBook(searchText: searchText, startIndex: startIndex, maxResults: maxResults).sink(receiveValue: { [weak self] books in
            if self?.books == nil {
                self?.books = books
            } else {
                self?.books?.items.append(contentsOf: books?.items ?? [])
            }
            if (books?.items.count ?? 0) < 20 {
                self?.shouldInfiniteScroll = false
            } else {
                self?.startIndex = self?.books?.items.count ?? 0
            }
        })
    }

    func loadNext() {
        guard let totalItems = books?.totalItems else { return }
        if startIndex < totalItems {
            search()
        }
    }
}
