//
//  BookModel.swift
//  swift-ui-mvvm
//
//  Created by jhseo on 2020/02/06.
//  Copyright © 2020 jhseo. All rights reserved.
//

import Foundation

struct BookModel: Codable {
    let totalItems: Int
    var items: [BookItem]
}
