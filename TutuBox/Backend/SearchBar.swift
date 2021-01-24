//
//  SearchBar.swift
//  TutuBox
//
//  Created by Brandon Plank on 7/12/20.
//  Copyright © 2020 Brandon Plank. All rights reserved.
//

import Foundation
import SwiftUI

/*
 This code is NOT mine, got it off Stack Overflow :)
 */

extension UIApplication {
    func endEditing(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct SearchBar: UIViewRepresentable {
    @Binding var text: String
    var onSearchButtonClicked: (() -> Void)? = nil
    var placeholder : String? = "Search for apps"
    
    class Coordinator: NSObject, UISearchBarDelegate {
        let control : SearchBar
        
        init(_ control: SearchBar){
            self.control = control
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
            control.text = searchText
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            control.onSearchButtonClicked?()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.placeholder = placeholder
        searchBar.searchBarStyle = .minimal
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
}


