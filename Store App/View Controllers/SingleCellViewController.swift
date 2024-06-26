//
//  SingleCellViewController.swift
//  Store App
//
//  Created by Mohd Kashif on 26/06/24.
//

import Foundation
import UIKit
import SwiftUI
class SingleCellViewController:UITableViewController{
    private var network=NetworkLayer()
    private var categories:[CategoryModel]=[]
//    lazy var image:UIImage={
//       let image=UIImage()
//        image.
//        return image
//    }()
    
//    lazy var categoryTitle:UILabel={
//       let label=UILabel()
//        label.text="Cloths"
//        label.font=UIFont.systemFont(ofSize: 24)
//        return label
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor=UIColor.red
        setupUI()
    }
    
    
    private func setupUI(){
        network.request(url: API.category, type: [CategoryModel].self) { error, data in
            if error==nil{
                guard let data=data else {
                    return
                }
                self.categories=data
                print(self.categories as Any,"CAtegorid")
            } else {
                print(error,"error")
            }
        }
    }
}


