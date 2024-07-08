//
//  CategoryModel.swift
//  Store App
//
//  Created by Mohd Kashif on 26/06/24.
//

import Foundation

struct CategoryModel:Codable{
    let id:Int
    let name:String
    let image:String
    let creationAt, updatedAt: String
}

struct Product: Codable {
    let id: Int
    let title: String
    let price: Int
    let description: String
    let category: Category
    let images: [String]
}

// MARK: - Category
struct Category: Codable,Hashable {
    let id: Int
    let name: String
    let image: String
}
