//
//  AddProductViewController.swift
//  Store App
//
//  Created by Mohd Kashif on 09/07/24.
//

import Foundation
import UIKit
import SwiftUI
class AddProductViewController:UIViewController{
    var selectedCategory:Category?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor=UIColor.white
        setupUI()
    }
    
    lazy var titleTextField:UITextField={
       let textField=UITextField()
        textField.placeholder="Enter Title"
        textField.leftView=UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = .always
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    lazy var categoryPickerView:CategoryPickerView={
        let picker=CategoryPickerView {[weak self] category in
            print(category,"category")
            self?.selectedCategory=category
        }
        return picker
    }()
    
    lazy var priceTextField:UITextField={
       let textField=UITextField()
        textField.placeholder="Enter Price"
        textField.leftView=UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = .always
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        return textField
    }()
    
    lazy var descriptionTextField:UITextView={
        let textField=UITextView()
        textField.contentInsetAdjustmentBehavior = .automatic
        textField.backgroundColor=UIColor.lightGray
        return textField
    }()
    
    lazy var imageUrlField:UITextField={
        let textField=UITextField()
         textField.placeholder="Enter Image Url"
         textField.leftView=UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
         textField.leftViewMode = .always
         textField.borderStyle = .roundedRect
         return textField
    }()
    private func setupUI(){
        let stack=UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints=false
        stack.axis = .vertical
        stack.spacing=UIStackView.spacingUseSystem
        stack.isLayoutMarginsRelativeArrangement=true
        stack.directionalLayoutMargins=NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        stack.addArrangedSubview(titleTextField)
        stack.addArrangedSubview(priceTextField)
        stack.addArrangedSubview(descriptionTextField)
        let hostingController=UIHostingController(rootView: categoryPickerView)
        stack.addArrangedSubview(hostingController.view)
        addChild(hostingController)
        hostingController.didMove(toParent: self)
        stack.addArrangedSubview(imageUrlField)
        view.addSubview(stack)
        
        // add constraint
        
        stack.widthAnchor.constraint(equalTo: view.widthAnchor).isActive=true
        stack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive=true
        descriptionTextField.heightAnchor.constraint(equalToConstant: 200).isActive=true
    }
    
}

struct AddProductViewControllerReprestable:UIViewControllerRepresentable{
    func makeUIViewController(context: Context) -> some UIViewController {
        AddProductViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
}

//#Preview(body: {
//    AddProductViewControllerReprestable()
//})


extension UIColor{
    static var lightGrey = UIColor(red: 247, green: 242, blue: 242, alpha: 1)
}
