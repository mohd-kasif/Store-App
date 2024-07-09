//
//  Extensions.swift
//  Store App
//
//  Created by Mohd Kashif on 09/07/24.
//

import Foundation
import UIKit
import SwiftUI
extension Int{
    func formatCurrency()->String{
        let formatter=NumberFormatter()
        formatter.numberStyle = .currency
        return formatter.string(from: NSNumber(value: self)) ?? "0"
    }
}
extension String{
    var isNumeric:Bool{
        Double(self) != nil
    }
}


extension UIViewController{
    func showAlert(title:String, message:String){
        let showAlertVC=UIAlertController(title: title, message: message, preferredStyle: .alert)
        showAlertVC.addAction(UIAlertAction(title: title, style: .default))
        present(showAlertVC, animated: true)
    }
    
    func showMessage(title:String, message:String, type:MessageType){
        let controller=UIHostingController(rootView: MessageView(title: title, message: message, type: type))
        guard let messageView=controller.view else {return}
        view.addSubview(messageView)
        messageView.translatesAutoresizingMaskIntoConstraints=false
        addChild(controller)
        controller.didMove(toParent: self)
        
        // constraint
        
        messageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive=true
        messageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive=true
        messageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive=true
        
        DispatchQueue.main.asyncAfter(deadline: .now()+5){
            messageView.removeFromSuperview()
        }
    }
}

