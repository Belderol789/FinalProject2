//
//  SecondCustomTextField.swift
//  FinalProject2
//
//  Created by Obiet Panggrahito on 20/05/2017.
//  Copyright © 2017 Burst. All rights reserved.
//

import UIKit

@IBDesignable
class SecondCustomTextField: UITextField {
    
    var placeholderText = "default"
    var isPressed = false
    var keyboardYLocation = CGFloat()
    var textFieldYLocation = CGFloat()
    var yTransformation = CGFloat()
    
    var superviewWentUp = false
    
    override func awakeFromNib() {
        self.delegate = self
    }
    
    override func draw(_ rect: CGRect) {
        UserInterfaceDesign.drawCustomTextField(frame: self.bounds, resizing: .stretch, pressed: isPressed, textFieldText: placeholderText)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isPressed = true
        self.setNeedsDisplay()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShown), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    
    func keyboardShown(notification: NSNotification, textField: UITextField) {
        let info = notification.userInfo!
        let keyboardFrame = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        keyboardYLocation = keyboardFrame.origin.y
        textFieldYLocation = textField.frame.origin.y
        yTransformation = keyboardYLocation - textFieldYLocation - 45 //height of textField is 40
        
        if textFieldYLocation > keyboardYLocation {
            superview?.frame = (superview?.frame.applying(CGAffineTransform(translationX: 0, y: yTransformation)))!
            superviewWentUp = !superviewWentUp
        }
    }
}

extension SecondCustomTextField: UITextFieldDelegate {
    
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
