//
//  BookItem.swift
//  swift-ui-mvvm
//
//  Created by jhseo on 2020/02/06.
//  Copyright © 2020 jhseo. All rights reserved.
//

import Foundation

struct BookItem: Codable, Identifiable {
    var id = UUID()
    let volumeInfo: VolumeInfo

    enum CodingKeys: String, CodingKey {
        case volumeInfo = "volumeInfo"
    }
}
