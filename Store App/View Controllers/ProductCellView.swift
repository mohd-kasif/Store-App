//
//  ProductCellView.swift
//  Store App
//
//  Created by Mohd Kashif on 09/07/24.
//

import SwiftUI

struct ProductCellView: View {
    var product:Product
    var body: some View {
        HStack(alignment: .top){
            VStack(alignment: .leading, spacing: 10){
                Text(product.title)
                    .bold()
                Text(product.description)
            }
            Spacer()
            Text(product.price, format: .currency(code: "INR"))
                .padding(5)
                .background(.green)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10), style: .continuous))
        }
    }
}

#Preview {
    ProductCellView(product: Product(id: 1, title: "Hell Bent", price: 544, description: "fintech orivate limited", category: Category(id: 4, name: "Kashif", image: ""), images: [""]))
}
