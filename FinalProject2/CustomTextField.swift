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
    
    var placeholderText = "default"
    var isPressed = false
    
    override func awakeFromNib() {
        self.delegate = self
    }

    override func draw(_ rect: CGRect) {
//        UserInterfaceDesign.drawTextField(frame: self.bounds, resizing: .stretch, pressed: isPressed, textFieldText: placeholderText, textFieldWidth: 343)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isPressed = true
        self.setNeedsDisplay()
    }
    
    func moveTextField (_ textField : UITextField, moveDistance : Int, up : Bool) {
        let moveDuration = 0.3
        let movement : CGFloat = CGFloat( up ? moveDistance : -moveDistance)
        
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.frame = self.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
}

extension CustomTextField: UITextFieldDelegate {
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        superview?.endEditing(true)
        return false
    }
        
    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveTextField(textField, moveDistance: -250, up: true)
    }
        
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        moveTextField(textField, moveDistance: -250, up: false)
        if textField.text == "" {
            isPressed = false
            self.setNeedsDisplay()
        }
    }
    
}
