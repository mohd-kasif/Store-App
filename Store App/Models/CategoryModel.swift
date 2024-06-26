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
