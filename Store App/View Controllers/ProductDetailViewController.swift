//
//  ProductDetailViewController.swift
//  Store App
//
//  Created by Mohd Kashif on 09/07/24.
//

import Foundation
import UIKit

class ProductDetailViewController:UIViewController{
    private var productDetail:Product
    private var network=NetworkLayer()
    init(productDetail: Product) {
        self.productDetail = productDetail
        print(self.productDetail,"product detil")
        super.init(nibName: nil, bundle: nil)
        UILabel.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).adjustsFontSizeToFitWidth=true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var price:UILabel={
        let label=UILabel()
        return label
    }()
    
    lazy var descriptionLabel:UILabel={
        let label=UILabel()
        label.numberOfLines=0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints=false
        return label
        
    }()
    
    lazy var deleteButton:UIButton={
        let button=UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints=false
        button.setTitle("Delete", for: .normal)
        button.addTarget(self, action: #selector(deleteProduct(_ :)), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor=UIColor.white
        title=productDetail.title
        setupUI()
        
    }
    
    @objc private func deleteProduct(_ sender:UIButton){
        Task{
            let isDeleted=try await network.deleteProduct(id: productDetail.id)
            if isDeleted{
                self.navigationController?.popViewController(animated: true)
            }
        }
//        network.request(url: URL.deleteProduct(productDetail.id), type: DeleteResponseModel.self, httpMethod: .delete) { error, data in
//            if error==nil{
//                guard let data=data else {return}
//                print(data,"delete respnse success")
//                let _ = self.navigationController?.popViewController(animated: true)
//            } else {
//                print(error as Any,"error in deleting")
//            }
//        }
    }
    
    private func setupUI(){
        let stack=UIStackView()
        stack.spacing=10
        stack.axis = .vertical
        stack.alignment = .top
        stack.layoutMargins=UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        stack.isLayoutMarginsRelativeArrangement=true
        stack.translatesAutoresizingMaskIntoConstraints=false
        
        descriptionLabel.text=productDetail.description
        price.text=productDetail.price.formatCurrency()
        
        stack.addArrangedSubview(descriptionLabel)
        stack.addArrangedSubview(price)
        stack.addArrangedSubview(deleteButton)
        
        view.addSubview(stack)
        
        // contraint
        stack.widthAnchor.constraint(equalTo: view.widthAnchor).isActive=true
        
    }
}
