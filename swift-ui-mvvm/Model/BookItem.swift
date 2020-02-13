//
//  BookItem.swift
//  swift-ui-mvvm
//
//  Created by jhseo on 2020/02/06.
//  Copyright © 2020 jhseo. All rights reserved.
//

import Foundation

struct BookItem: Codable, Identifiable {
    var id = UUID() // .sheet를 사용하기 위해서는 unique id가 필요하다.
    let volumeInfo: VolumeInfo

    enum CodingKeys: String, CodingKey {
        case volumeInfo = "volumeInfo"
    }
}

extension BookItem: Hashable {
    static func == (lhs: BookItem, rhs: BookItem) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
