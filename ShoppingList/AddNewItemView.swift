//
//  AddNewItemView.swift
//  Gylsboda
//
//  Created by David Szemenkar on 2018-04-19.
//  Copyright © 2018 David Szemenkar. All rights reserved.
//

import Foundation
import UIKit


class AddNewItemView: UIView, UITextFieldDelegate {
    
    var placeHolderText: String!
    var addNewItemViewClosure: (String) -> ()
    
    init(controller: UIViewController, placeHolderText: String, addNewItemViewClosure: @escaping (String) -> ()) {
        
        self.placeHolderText = placeHolderText
        self.addNewItemViewClosure = addNewItemViewClosure
        
        super.init(frame: controller.view.frame)
        setup()
    }

    private func setup() {
        self.backgroundColor = UIColor.lightGray
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 44))
        headerView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        let textField = UITextField(frame: headerView.frame)
        textField.placeholder = self.placeHolderText
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = .always
        textField.delegate = self
        headerView.addSubview(textField)
        
        self.addSubview(headerView)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let text = textField.text!
        
        self.addNewItemViewClosure(text)

        textField.text = ""
        return textField.resignFirstResponder()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
