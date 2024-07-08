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
    private var productsByCategory:[Product]=[]
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
        title="Categories"
        navigationController?.navigationBar.prefersLargeTitles=true
//        view.backgroundColor=UIColor.red
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Category")
        setupUI()
//        getProductByID(1)
        
    }
    
    
    private func setupUI(){
        network.request(url: URL.allCategory, type: [CategoryModel].self) { error, data in
            if error==nil{
                guard let data=data else {
                    return
                }
                self.categories=data
//                print(self.categories as Any,"CAtegorid")
                self.tableView.reloadData()
            } else {
                print(error as Any,"error")
            }
        }
    }
    
    private func getProductByID(_ id :Int){
        network.request(url: URL.getProductByCategory(id), type: [Product].self) { error, data in
            if error==nil{
                guard let data=data else{
                    return
                }
                    self.productsByCategory=data
                
            } else {
                print(error as Any, "error")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRow=categories[indexPath.row]
        let view=ProductTableViewController(category: selectedRow)
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "Category", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        let category=categories[indexPath.row]
        var config=cell.defaultContentConfiguration()
        config.text=category.name
        if let url=URL(string: category.image){
            DispatchQueue.global().async {
                if let data=try? Data(contentsOf: url){
                    DispatchQueue.main.async {
                        let image=UIImage(data: data)
                        config.image=image
                        config.imageProperties.maximumSize=CGSize(width: 70, height: 70)
                        cell.contentConfiguration=config
                    }
                }
            }
        }
        return cell
    }
}


