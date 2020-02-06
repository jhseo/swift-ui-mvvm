//
//  LoadingRow.swift
//  swift-ui-mvvm
//
//  Created by jhseo on 2020/02/06.
//  Copyright © 2020 jhseo. All rights reserved.
//

import SwiftUI

struct LoadingRow : View {
    @State var isLoading: Bool

    var body: some View {
        HStack {
            Spacer()
            ActivityIndicatorView(isLoading: isLoading)
            Spacer()
        }
    }
}
