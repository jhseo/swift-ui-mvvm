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
        // 실제로는 List의 Row지만 systemGroupedBackground와 동일한 색상으로 보여줘야 자연스럽기 때문에 변경한다
        .listRowBackground(Color(UIColor.systemGroupedBackground))
    }
}
