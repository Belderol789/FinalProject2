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
    var keyboardYLocation = CGFloat()
    var textFieldYLocation = CGFloat()
    var yTransformation = CGFloat()
    
    var superviewWentUp = false
    
    override func awakeFromNib() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShown), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        self.delegate = self
    }
    
    override func draw(_ rect: CGRect) {
        UserInterfaceDesign.drawCustomTextField(frame: self.bounds, resizing: .aspectFit, pressed: isPressed, textFieldText: placeholderText)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isPressed = true
        self.setNeedsDisplay()
    }
    
    func keyboardShown(notification: NSNotification, textField: UITextField) {
        let info = notification.userInfo!
        let keyboardFrame = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        keyboardYLocation = keyboardFrame.origin.y
        textFieldYLocation = textField.frame.origin.y
        yTransformation = keyboardYLocation - textFieldYLocation - 60 //height of textField is 55
        
        if textFieldYLocation > keyboardYLocation {
            superview?.frame = (superview?.frame.applying(CGAffineTransform(translationX: 0, y: yTransformation)))!
            superviewWentUp = !superviewWentUp
        }
    }
}

extension CustomTextField: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        superview?.endEditing(true)
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        
        if superviewWentUp {
            superview?.frame = (superview?.frame.applying(CGAffineTransform(translationX: 0, y: -(yTransformation))))!
            superviewWentUp = !superviewWentUp
        }
        
        if textField.text == "" {
            isPressed = false
            self.setNeedsDisplay()
        }
    }
    
}
