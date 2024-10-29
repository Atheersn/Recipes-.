//
//  5.swift
//  teast 4
//
//  Created by Atheer Salem Alnashi on 24/04/1446 AH.
//
import SwiftUI
import Combine

// Define the Ingredient struct
struct Ingredient: Identifiable {
    let id = UUID()
    var name: String
    var measurement: String
    var serving: Int
}

// Define the Recipe struct
struct Recipe: Identifiable {
    let id = UUID()
    var title: String
    var description: String
    var ingredients: [Ingredient]
    var image: UIImage?
}
