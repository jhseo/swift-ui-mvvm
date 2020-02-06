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

