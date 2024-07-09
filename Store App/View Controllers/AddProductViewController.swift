//
//  AddProductViewController.swift
//  Store App
//
//  Created by Mohd Kashif on 09/07/24.
//

import Foundation
import UIKit
import SwiftUI


enum AddProductField:Int{
    case title
    case price
    case imageUrl
}

protocol AddProductViewControllerDelegate:AnyObject{
    func addProductViewControllerDidCancel(controller:AddProductViewController)
    func addProductViewControllerSaveProduct(product:Product, controller:AddProductViewController)
}

struct AddValidationTextField{
    var title:Bool=false
    var price:Bool=false
    var imageUrl:Bool=false
    var description:Bool=false
    var isValid:Bool{
        title && price && imageUrl && description
    }
}
class AddProductViewController:UIViewController{
    var selectedCategory:Category?
    weak var delegate:AddProductViewControllerDelegate?
    private var addValidationField=AddValidationTextField()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor=UIColor.white
        navigationItem.rightBarButtonItem=saveButton
        navigationItem.leftBarButtonItem=cancelButton
        setupUI()
    }
    
    lazy var titleTextField:UITextField={
       let textField=UITextField()
        textField.placeholder="Enter Title"
        textField.leftView=UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = .always
        textField.borderStyle = .roundedRect
        textField.addTarget(self, action: #selector(textFieldChange(_:)), for: .editingChanged)
        textField.tag=AddProductField.title.rawValue
        return textField
    }()
    
    lazy var saveButton:UIBarButtonItem={
        let button=UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveProduct))
        button.isEnabled=false
        return button
    }()
    
    lazy var cancelButton:UIBarButtonItem={
        let button=UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelProduct))
        return button
    }()
    
    
    @objc private func saveProduct(){
        guard let title=titleTextField.text, let price = priceTextField.text, let description=descriptionTextField.text, let selectedCategory=selectedCategory, let imageUrl=imageUrlField.text else {return}
//        let product=ProductPayload(title: title, price: Int(price)!, description: description, categoryId: selectedCategory.id, images: [selectedCategory.image])
        let product=Product(id: selectedCategory.id, title: title, price: Int(price)!, description: description, category: selectedCategory, images: [imageUrl])
        delegate?.addProductViewControllerSaveProduct(product: product, controller: self)
        
    }
    @objc private func cancelProduct(){
        delegate?.addProductViewControllerDidCancel(controller: self)
    }
    
    @objc private func textFieldChange(_ sender:UITextField){
        guard let text=sender.text else {return}
            switch sender.tag{
            case AddProductField.title.rawValue:
                addValidationField.title = !text.isEmpty
            case AddProductField.price.rawValue:
                addValidationField.price = !text.isEmpty && text.isNumeric
            case AddProductField.imageUrl.rawValue:
                addValidationField.imageUrl = !text.isEmpty
            default:
                break
            }
        
        saveButton.isEnabled=addValidationField.isValid
    }
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
        textField.addTarget(self, action: #selector(textFieldChange(_:)), for: .editingChanged)
        textField.tag=AddProductField.price.rawValue
        return textField
    }()
    
    lazy var descriptionTextField:UITextView={
        let textField=UITextView()
        textField.contentInsetAdjustmentBehavior = .automatic
        textField.backgroundColor=UIColor.lightGray
        textField.delegate=self
        return textField
    }()
    
    lazy var imageUrlField:UITextField={
        let textField=UITextField()
         textField.placeholder="Enter Image Url"
         textField.leftView=UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
         textField.leftViewMode = .always
         textField.borderStyle = .roundedRect
        textField.addTarget(self, action: #selector(textFieldChange(_:)), for: .editingChanged)
        textField.tag=AddProductField.imageUrl.rawValue
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
        UINavigationController(rootViewController: AddProductViewController())
        
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


extension AddProductViewController:UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        addValidationField.description = !textView.text.isEmpty
        saveButton.isEnabled=addValidationField.isValid
    }
}
