//
//  ImageLoader.swift
//  swift-ui-mvvm
//
//  Created by jhseo on 2020/02/06.
//  Copyright © 2020 jhseo. All rights reserved.
//

import SwiftUI
import Combine

final class ImageLoader: ObservableObject {
    var didChange = PassthroughSubject<Data, Never>()

    var data = Data() {
        didSet {
            didChange.send(data)
        }
    }

    init(imageURL: String) {
        guard let url = URL(string: imageURL) else { return }

        URLSession.shared.dataTask(with: url) { (data, reponse, error) in
            guard let data = data else { return }

            DispatchQueue.main.async {
                self.data = data
            }
        }.resume()
    }
}
