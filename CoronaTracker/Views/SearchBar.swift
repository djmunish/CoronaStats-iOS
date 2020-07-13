//
//  SearchBar.swift
//  CoronaTracker
//
//  Created by Munish Sehdev on 2020-07-13.
//  Copyright © 2020 Munish Sehdev. All rights reserved.
//

import SwiftUI

struct SearchBar: UIViewRepresentable {

    @Binding var text: String
    var action: (() -> Void)?
    let placeholder: String

    class Coordinator: NSObject, UISearchBarDelegate {

        @Binding var text: String
        var action: (() -> Void)?

        init(text: Binding<String>, action: (() -> Void)?) {
            _text = text
            self.action = action
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
            action!()
        }
        
    }

    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text, action: action)
    }

    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = placeholder
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
}

extension SearchBar {

    func searchCallback(perform action: @escaping () -> Void ) -> Self {
         var copy = self
         copy.action = action
         return copy
     }
}
