//
//  View+Extension.swift
//  swift-ui-mvvm
//
//  Created by jhseo on 2020/02/13.
//  Copyright © 2020 jhseo. All rights reserved.
//

import SwiftUI

extension View {
    func resignKeyboardOnDragGesture() -> some View {
        modifier(ResignKeyboardOnDragGesture())
    }

    func loadNext<T: Hashable>(_ item: T, _ items: [T], handler: @escaping () -> Void) -> some View {
        modifier(LoadNextModifier(item: item, items: items, handler: handler))
    }
}

private struct HiddenModifier: ViewModifier {
    private let isHidden: Bool
    func body(content: Content) -> some View {
        Group {
            if isHidden {
                content.hidden()
            } else {
                content
            }
        }
    }
}

private struct ResignKeyboardOnDragGesture: ViewModifier {
    private var gesture = DragGesture().onChanged{ _ in
        UIApplication.shared.endEditing(true)
    }
    func body(content: Content) -> some View {
        content.gesture(gesture)
    }
}

private struct LoadNextModifier<T: Hashable>: ViewModifier {
    let item: T
    let items: [T]

    var handler: () -> Void

    func body(content: Content) -> some View {
        content.onAppear {
            if self.item == self.items.last! {
                self.handler()
            }
        }
    }
}
