//
//  SearchBar.swift
//  swift-ui-mvvm
//
//  Created by jhseo on 2020/02/06.
//  Copyright © 2020 jhseo. All rights reserved.
//

import SwiftUI

struct SearchBar: UIViewRepresentable {
    var placeHolder: String = ""
    @Binding var searchText: String

    class Coordinator: NSObject, UISearchBarDelegate {
        var placeHolder: String = ""
        @Binding var text: String

        init(placeHolder: String, text: Binding<String>) {
            self._text = text
            self.placeHolder = placeHolder
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
    }

    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(placeHolder: placeHolder, text: $searchText)
    }

    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.placeholder = placeHolder
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = searchText
        uiView.backgroundImage = UIImage().imageWithColor(color: .systemBackground)
    }
}
