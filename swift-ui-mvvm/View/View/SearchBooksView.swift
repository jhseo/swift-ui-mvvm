//
//  SearchBooksView.swift
//  swift-ui-mvvm
//
//  Created by jhseo on 2020/02/06.
//  Copyright © 2020 jhseo. All rights reserved.
//

import SwiftUI

struct SearchBooksView: View {
    @ObservedObject var viewModel = SearchBooksViewModel()

    init() {
        UITableView.appearance().separatorStyle = .none
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                SearchBar(placeHolder: "Search books", searchText: self.$viewModel.searchText)
                bookListView
            }
            .background(Color(UIColor.systemGroupedBackground))
            .edgesIgnoringSafeArea(.bottom)
            .resignKeyboardOnDragGesture() // drag시 keyboard 감추도록 함
            .navigationBarTitle(Text("Search"))
        }
        .navigationViewStyle(StackNavigationViewStyle()) // Pad에서 SplitView(DoubleColumnNavigationViewStyle)을 사용하지 않음
    }

    var bookListView: some View {
        Group {
            viewModel.books.map { books in
                List { // List에 Array를 넣는 방식이 보편적이나 마지막Row에 LoadingRow를 Insert하기 위해서는 ForEach를 사용해야 함
                    Section(header: Text("Results (\(books.totalItems))")) {
                        ForEach(Array(books.items.enumerated()), id: \.offset) { (index, book) in
                            BookRow(book: book.volumeInfo)
                                .onAppear { // 마지막 row일때 다음 항목을 로딩함
                                    if index == books.items.count - 1 {
                                        self.viewModel.loadNext()
                                    }
                                }
                        }
                        // Section 마지막에 LoadingRow를 붙여준다
                        if self.viewModel.shouldInfiniteScroll {
                            LoadingRow(isLoading: true)
                        }
                    }
                }
                .listStyle(GroupedListStyle())
            }
            Spacer()
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBooksView()
    }
}
