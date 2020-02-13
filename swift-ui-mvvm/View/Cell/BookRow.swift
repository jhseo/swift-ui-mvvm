//
//  BookRow.swift
//  swift-ui-mvvm
//
//  Created by jhseo on 2020/02/06.
//  Copyright © 2020 jhseo. All rights reserved.
//

import SwiftUI

struct BookRow: View {
    var book: VolumeInfo
    @State var showDetail: Bool = false

    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 4.0) {
                ImageView(imageURL: book.imageLinks?.smallThumbnail ?? "")
                VStack(alignment: .leading, spacing: 4.0) {
                    Text(book.title)
                        .font(.system(size: 14))
                        .fontWeight(.bold)
                    Text(book.authors?.joined(separator: ", ") ?? "")
                        .foregroundColor(.gray)
                        .font(.system(size: 14))
                    Text(book.publishedDate ?? "")
                        .foregroundColor(.gray)
                        .font(.system(size: 10))
                }
            }
            Divider()
        }
        .listRowInsets(EdgeInsets(top: 8, leading: 8, bottom: 0.33, trailing: 4))
        // 탭할때 showDetail을 변경
        .onTapGesture {
            self.showDetail = true
        }
        // NavigationLink(Push)를 쓰면 NavigationBar가 중복으로 나와서 Present 방식으로 띄움
        .sheet(isPresented: self.$showDetail) { 
            URL(string: self.book.infoLink ?? "")
                .map { SafariView(url: $0) }
        }
    }
}

struct BookRow_Previews: PreviewProvider {
    static var previews: some View {
        BookRow(
            book: VolumeInfo(
                title: "Title",
                authors: ["Author1", "Author2"],
                publishedDate: "2020-2-1",
                imageLinks: ImageLinks(
                    smallThumbnail: "https://i.picsum.photos/id/820/302/302.jpg",
                    thumbnail: "https://i.picsum.photos/id/820/302/302.jpg"),
                infoLink: "")
        )
    }
}

