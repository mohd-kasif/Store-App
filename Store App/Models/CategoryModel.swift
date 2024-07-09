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

struct ProductPayload:Codable{
    let title:String
    let price:Int
    let description:String
    let categoryId:Int
    let images:[String]
    init(product:Product){
        self.title=product.title
        self.price=product.price
        self.description=product.description
        self.categoryId=product.id
        self.images=product.images
    }
}

struct AddProductResponse: Codable {
    let title: String
    let price: Int
    let description: String
    let images: [String]
    let category: AddProductCategory
    let id: Int
    let creationAt, updatedAt: String
}

// MARK: - Category
struct AddProductCategory: Codable {
    let id: Int
    let name: String
    let image: String
    let creationAt, updatedAt: String
}

struct DeleteResponseModel:Codable{
    let path:String?
    let timestamp:String?
    let name:String?
    let message:String?

}
