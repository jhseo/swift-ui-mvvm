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
    @State var bookItem: BookItem? = nil // 탭할때 SafariView로 띄울 item

    init() {
        UITableView.appearance().separatorStyle = .none
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                SearchBar(placeHolder: "Search books", searchText: self.$viewModel.searchText)
                viewModel.books.map { books in
                    List { // List에 Array를 넣는 방식이 보편적이나 마지막Row에 LoadingRow를 Insert하기 위해서는 ForEach를 사용해야 함
                        Section(header: Text("Results (\(books.totalItems))")) {
                            ForEach(Array(books.items.enumerated()), id: \.offset) { (index, book) in
                                BookRow(book: book.volumeInfo)
                                    .listRowInsets(EdgeInsets(top: 8, leading: 8, bottom: 0.33, trailing: 4))
                                    .onAppear { // 마지막 row일때 다음 항목을 로딩함
                                        if index == books.items.count - 1 {
                                            self.viewModel.loadNext()
                                        }
                                    }
                                    .onTapGesture { // 탭할때 SafariView로 띄울 item
                                        self.bookItem = book
                                    }
                                    .sheet(item: self.$bookItem, content: { book in
                                        URL(string: book.volumeInfo.infoLink ?? "")
                                            .map { SafariView(url: $0) }
                                    }) // NavigationLink(Push)를 쓰면 NavigationBar가 중복으로 나와서 Present 방식으로 띄움
                            }
                            // Section 마지막에 LoadingRow를 붙여준다
                            if self.viewModel.shouldInfiniteScroll {
                                LoadingRow(isLoading: true)
                                    .listRowBackground(Color(UIColor.systemGroupedBackground))
                            }
                        }
                    }
                    .listStyle(GroupedListStyle())
                }
                Spacer()
            }
            .background(Color(UIColor.systemGroupedBackground))
            .edgesIgnoringSafeArea(.bottom)
            .resignKeyboardOnDragGesture() // drag시 keyboard 감추도록 함
            .navigationBarTitle(Text("Search"))
        }
        .navigationViewStyle(StackNavigationViewStyle()) // SplitView(DoubleComnNavigationViewStyle)을 사용하지 않음
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBooksView()
    }
}
