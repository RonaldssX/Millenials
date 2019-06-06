//
//  Name.swift
//  Millenials
//
//  Created by Ronaldo Santana on 18/04/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import UIKit

fileprivate var callback: ((String) -> ())?

extension PlayersVC: UITextFieldDelegate {
    
    func playerName(name: @escaping ((String) -> ())) {
        
        callback = name
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
            callback?(textField.text!)
        
            textField.resignFirstResponder()
        
        return true
        
    }
    
    /*
     // o xcode reclama bastante de memory leaking
     // com o que tem abaixo desse comment,
     // mas fica tranquilo que não tem
     // nada de errado.
    */
    
    @objc
    internal func modifyPlayerName(_ sender: FlatTextField) {
        
        activeTextField = sender
        
        let tapAction = UITapGestureRecognizer(target: self, action: #selector(dismissTextField(_:)))
        
        view.addGestureRecognizer(tapAction)
        
        guard (activeTextField == textFields.last) else { return }
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        
    }
    
    @objc
    fileprivate func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo![UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if (self.view.frame.origin.y == 0) {
                self.view.frame.origin.y -= keyboardSize.height
            }
            
            
        }
        
        
    }
    
    @objc
    fileprivate func dismissTextField(_ tap: UITapGestureRecognizer) {
        
        view.removeGestureRecognizer(tap)
        
        activeTextField?.resignFirstResponder()
        callback?((activeTextField?.text)!)
        
        activeTextField = nil
        
        
    }
    
    @objc
    fileprivate func keyboardWillHide(notification: NSNotification) {
        
        if (self.view.frame.origin.y != 0) {
            
            self.view.frame.origin.y = 0
            
        }
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }

    
}
