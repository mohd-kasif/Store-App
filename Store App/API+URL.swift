//
//  API+URL.swift
//  Store App
//
//  Created by Mohd Kashif on 26/06/24.
//

import Foundation

enum API{
    static let category="https://api.escuelajs.co/api/v1/categories"
}

extension URL{
    static var development:URL{
        return URL(string:"https://api.escuelajs.co")!
    }
    static var production:URL{
        return URL(string:"https://escuelajs.co")!
    }
    
    static var `deafult`:URL{
        #if DEBUG
            return development
        #else
            return production
        #endif
    }
    
    static var allCategory:URL{
        URL(string:"/api/v1/categories", relativeTo: Self.deafult)!
    }
    // https://api.escuelajs.co/api/v1/categories/1/products
    static func getProductByCategory(_ id:Int)->URL{
        return URL(string:"/api/v1/categories/\(id)/products",relativeTo: Self.deafult)!
    }
}
