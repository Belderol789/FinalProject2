//
//  customTextField.swift
//  TryPaintCode
//
//  Created by Obiet Panggrahito on 14/05/2017.
//  Copyright © 2017 Obiet Panggrahito. All rights reserved.
//

import UIKit

@IBDesignable
class CustomTextField: UITextField {
    
    var placeHolderTextCustom = "Default"
    var isPressed = false
    
    override func awakeFromNib() {
        self.delegate = self
    }
    
    override func draw(_ rect: CGRect) {
        UserInterfaceDesign.drawCustomTextField(frame: self.bounds, resizing: .stretch, pressed: isPressed, textFieldText: placeHolderTextCustom)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isPressed = true
        self.setNeedsDisplay()
    }
}

extension CustomTextField: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        superview?.endEditing(true)
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        
        if textField.text == "" {
            isPressed = false
            self.setNeedsDisplay()
        }
    }
    
}
