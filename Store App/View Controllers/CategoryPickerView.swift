//
//  CategoryPickerView.swift
//  Store App
//
//  Created by Mohd Kashif on 09/07/24.
//

import SwiftUI

struct CategoryPickerView: View {
    let network=NetworkLayer()
    @State var category:[Category]=[]
    @State var selectedCategory:Category?
    
    let onSelected:(Category)->Void
    
    var body: some View {
        Picker("", selection: $selectedCategory) {
            ForEach(category, id: \.id){category in
                Text(category.name)
                    .tag(Optional(category))
            }
        }
        .onChange(of: selectedCategory, perform: { value in
            if let category=value{
                onSelected(category)
            }
        })
        .pickerStyle(.wheel)
        .onAppear{
            getCategory()
        }
    }
}

#Preview {
    CategoryPickerView { category in
        
    }
}

extension CategoryPickerView{
    private func getCategory(){
        network.request(url: URL.allCategory, type: [Category].self) { error, data in
            if error==nil{
                DispatchQueue.main.async {
                    guard let data=data else {return}
                    self.category=data
                }
            } else {
                print(error as Any,"error")
            }
        }
    }
}
