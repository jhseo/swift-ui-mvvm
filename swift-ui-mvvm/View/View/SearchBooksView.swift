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
        UITableView.appearance().separatorStyle = .none // LoadingRow에도 Separator가 나오는데 부자연스럽기 때문에 BookRow에서 Divider를 추가하는 방식으로 Custom한다.
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
                        ForEach(books.items) { book in
                            BookRow(book: book.volumeInfo)
                                // 마지막 row일때 다음 항목을 로딩함
                                .loadNext(book, books.items) {
                                    self.viewModel.loadNext()
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
