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
    private var cancellable: AnyCancellable? = nil // dataTaskPublisher를 사용할때는 cancellable이 필요하다 cancellable은 deinit될 때 stream을 cancel하여 memory를 확보한다.
    private var startIndex: Int = 0
    private let maxResults: Int = 20

    // 마지막 페이지까지 로딩이 끝나면 false로 변경해서 LoadingRow를 보여주지 않고 API호출을 하지 않는다
    var shouldInfiniteScroll: Bool = true

    // searchText가 변경되면 값을 초기화하고 search method를 호출한다.
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
        guard shouldInfiniteScroll else { return } // shouldInfiniteScroll이 false인 경우에만 동작
        cancellable = APIService.searchBook(searchText: searchText, startIndex: startIndex, maxResults: maxResults)
            .sink(receiveValue: { [weak self] books in
                guard let `self` = self else { return }
                // 검색 결과가 있으면 append하고 없으면 값을 그대로 넣어준다
                if self.books == nil {
                    self.books = books
                } else {
                    self.books?.items.append(contentsOf: books?.items ?? [])
                }
                // 검색된 결과 갯수가 maxResults보다 작으면 미지막 페이지이므로 Infinitescroll이 동작되지 않도록 한다.
                if (books?.items.count ?? 0) < self.maxResults {
                    self.shouldInfiniteScroll = false
                } else {
                    self.startIndex = self.books?.items.count ?? 0
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
