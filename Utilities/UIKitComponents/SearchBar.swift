//
//  SearchBar.swift
//  WeatherApp
//
//  Created by Bhuvana Ravuri on 11/04/24.
//

import SwiftUI
import UIKit

struct SearchBar: UIViewRepresentable {
    @Binding var text: String
    var placeholder: String = "Search for a city"
    
    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String
        
        init(text: Binding<String>) {
            _text = text
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText  // This updates the bound SwiftUI state
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }
    
    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.placeholder = placeholder
        searchBar.searchBarStyle = .minimal  // Use minimal style to remove background
        searchBar.backgroundImage = UIImage()
        searchBar.backgroundColor = UIColor.clear
        // Customization: Text color and font
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.textColor = UIColor.black  // Custom text color
            textField.font = UIFont.systemFont(ofSize: 16)  // Custom font size
            textField.backgroundColor = UIColor.white  // Background color of the text field
            textField.layer.cornerRadius = 10  // Rounded corners for the text field
            textField.clipsToBounds = true
            // Customization: Placeholder color
            if let placeholderLabel = textField.value(forKey: "placeholderLabel") as? UILabel {
                placeholderLabel.textColor = UIColor.red  // Custom placeholder color
            }
        }
        // Customization: Search icon and clear button
        searchBar.setImage(UIImage(systemName: "magnifyingglass"), for: .search, state: .normal)  // Custom search icon
        searchBar.setImage(UIImage(systemName: "xmark.circle.fill"), for: .clear, state: .normal)  // Custom clear button
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = text
    }
}
