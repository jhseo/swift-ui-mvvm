//
//  BookItem.swift
//  swift-ui-mvvm
//
//  Created by jhseo on 2020/02/06.
//  Copyright © 2020 jhseo. All rights reserved.
//

import Foundation

struct BookItem: Codable, Identifiable {
    var id = UUID() // .sheet, foreach를 사용하기 위해서는 unique id가 필요하다.
    let volumeInfo: VolumeInfo

    // 실제 json에는 id가 없기 때문에 volumnInfo를 맵핑해야 한다.
    enum CodingKeys: String, CodingKey {
        case volumeInfo
    }
}

// LoadNext에서 값을 비교하기 위해 추가
extension BookItem: Hashable {
    static func == (lhs: BookItem, rhs: BookItem) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
