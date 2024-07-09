//
//  ProductTableViewController.swift
//  Store App
//
//  Created by Mohd Kashif on 08/07/24.
//

import Foundation
import UIKit
import SwiftUI
class ProductTableViewController:UITableViewController{
    private  var category:CategoryModel
   private var network=NetworkLayer()
    private var allProduct:[Product]=[]
    init(category: CategoryModel) {
        self.category = category
        super.init(nibName: nil, bundle: nil)
//        self.setupUI(category.id)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var addProductButton:UIBarButtonItem={
        let button=UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addProduct))
        return button
    }()
    
    
    @objc private func addProduct(){
        let view=AddProductViewController()
        view.delegate=self
        let navContoller=UINavigationController(rootViewController: view)
        present(navContoller, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor=UIColor.green
        title=category.name
        navigationController?.navigationBar.prefersLargeTitles=true
        navigationItem.rightBarButtonItem=addProductButton
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Products")
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupUI(category.id)
        tableView.reloadData()
    }
    private func setupUI(_ id: Int){
        network.request(url: URL.getProductByCategory(id), type: [Product].self) { error, data in
            if error==nil{
                guard let data=data else {return}
                self.allProduct=data
                self.tableView.reloadData()
            } else {
                print(error as Any, "error in all product")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allProduct.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail=allProduct[indexPath.row]
        let view=ProductDetailViewController(productDetail: detail)
        navigationController?.pushViewController(view, animated: true)
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "Products", for: indexPath)
//        cell.accessoryType = .disclosureIndicator
        let product=allProduct[indexPath.row]
        cell.contentConfiguration=UIHostingConfiguration(content: { // this is available ios version <=16
            ProductCellView(product: product)
        })
//        var config=cell.defaultContentConfiguration()
//        config.text=product.title
//        config.secondaryText=product.description
//        config.secondaryText="$\(product.price)"
//        cell.contentConfiguration=config
        return cell
    }
}
extension ProductTableViewController:AddProductViewControllerDelegate{
    func addProductViewControllerSaveProduct(product: Product, controller: AddProductViewController) {
        
        guard let data=network.encode(model: ProductPayload(product: product)) else {return}
        network.request(url: URL.addProduct, type: Product.self, httpMethod: .Post, httpBody: data) { error, data in
            if error==nil{
                guard let data=data else{
                    return
                }
                controller.dismiss(animated: true)
                print(data,"data add product")
            } else {
                print(error as Any, "errro in adding product")
//                self.showAlert(title: "Error", message: "Unable to add product")
                self.showMessage(title: "Error", message: "Unablet to add product", type: .error)
            }
            
        }
    }
    
    func addProductViewControllerDidCancel(controller: AddProductViewController) {
        controller.dismiss(animated: true)
    }
    
    
}
