//
//  ImageView.swift
//  swift-ui-mvvm
//
//  Created by jhseo on 2020/02/06.
//  Copyright © 2020 jhseo. All rights reserved.
//

import SwiftUI

struct ImageView: View {
    @ObservedObject var imageLoader: ImageLoader
    @State var image: UIImage = UIImage()

    init(imageURL: String) {
        imageLoader = ImageLoader(imageURL: imageURL)
    }

    var body: some View {
        VStack {
            Image(uiImage: imageLoader.data.isEmpty ? image : UIImage(data: imageLoader.data)!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
        }
        // 해당 publisher의 event가 방출되면 실행하는 closure
        .onReceive(imageLoader.didChange) { data in
            self.image = UIImage(data: data) ?? UIImage()
        }
    }
}
