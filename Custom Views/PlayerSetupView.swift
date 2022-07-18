//
//  PlayerSetupView.swift
//  Millenials
//
//  Created by Ronaldo Santana on 14/04/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import UIKit

class PlayerSetupView: UIView {
    
    public var animationCallback: (() -> ())?
    
    public var rootViewController: UIViewController? {
        
        didSet {
            
            self.rootViewController?.view.addSubview(self)
            
            backgroundColor = self.rootViewController?.view.backgroundColor
            
            addConstraints()
            
        }
        
    }  
    
    public var playerPictureView: UIImageView! {
        
        didSet {
            
            self.playerPictureView.contentMode = .scaleAspectFit           
            
            self.playerPictureView.isUserInteractionEnabled = true
            self.playerPictureView.isExclusiveTouch = true
            
            self.playerPictureView.alpha = 0.0
            
            addSubview(self.playerPictureView)
            
            self.playerPictureView.translatesAutoresizingMaskIntoConstraints = false
            
            
            self.playerPictureView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            
            self.playerPictureView.topAnchor.constraint(equalTo: topAnchor, constant: 55).isActive = true
            self.playerPictureView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -55).isActive = true
            
            self.playerPictureView.heightAnchor.constraint(equalTo: self.playerPictureView.widthAnchor).isActive = true
            
            
            self.playerPictureView.backgroundColor = UIColor().randomPlayerColor()
            
            self.playerPictureView.rounded()
            
        }
       
        
    }
    
   
    
    public var playerTextField: UITextField! {
        
        didSet {
            
            self.playerTextField.isExclusiveTouch = true 
            
            self.playerTextField.delegate = rootViewController as! PlayersVC
            
            self.playerTextField.alpha = 0.0
            
            self.playerTextField.backgroundColor = UIColor.white
            
            addSubview(self.playerTextField)
            
            self.playerTextField.translatesAutoresizingMaskIntoConstraints = false            
            
            self.playerTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30).isActive = true
            self.playerTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true
            
            self.playerTextField.topAnchor.constraint(equalTo: playerPictureView.bottomAnchor).isActive = true
            self.playerTextField.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            
        }
        
    }
    
    public func display(completion: @escaping (() -> ())) {
        
        self.animationCallback = completion
        
        display()
        
        
        
    }
    
    public func display() {
        
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 2, initialSpringVelocity: 1, options: [.preferredFramesPerSecond60, .curveEaseInOut], animations: {
            
            self.playerPictureView.alpha = 1.0
            
        }, completion: {(completed) in
            
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 2, initialSpringVelocity: 1, options: [.preferredFramesPerSecond60, .curveEaseInOut], animations: {
                
                self.playerTextField.alpha = 1.0
                
            }, completion: {(completed) in
                
                self.animationCallback?()
                
            })
            
        })
        
    }
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
   
    
    private func addConstraints() {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        leadingAnchor.constraint(equalTo: superview!.leadingAnchor, constant: 20).isActive = true
        trailingAnchor.constraint(equalTo: superview!.trailingAnchor, constant: -20).isActive = true
        
        heightAnchor.constraint(equalToConstant: superview!.frame.height / 3).isActive = true
        
    }
}


fileprivate let colorsArray = [UIColor.PlayerColors().blue,
                     UIColor.PlayerColors().green,
                     UIColor.PlayerColors().red,
                     UIColor.PlayerColors().purple,
                     UIColor.PlayerColors().yellow,
                     UIColor.PlayerColors().orange]

fileprivate var colorOptions = colorsArray

fileprivate extension UIColor {
    
    
    private var colors: [UIColor]  {
        
        get {
            
            if (colorOptions.count == colorsArray.count - 4) {
                
                colorOptions = colorsArray
                
            }
            
            return colorOptions
            
        }
        
        set {
            
            colorOptions = newValue
            
        }
        
    }
    
    
    
    func randomPlayerColor() -> UIColor {
        
        let randomColor = colors.randomElement()!
        
            colors.remove(at: colors.firstIndex(of: randomColor)!)
        
            return randomColor
        
    }
    
    struct PlayerColors {
        
        let blue = UIColor(R: 83, G: 155, B: 243, alpha: 0.9)
        let green = UIColor(R: 88, G: 200, B: 144, alpha: 0.9)
        let red = UIColor(R: 252, G: 4, B: 36, alpha: 0.9)
        let purple = UIColor(R: 220, G: 4, B: 252, alpha: 0.9)
        let yellow = UIColor(R: 252, G: 220, B: 4, alpha: 0.9)
        let orange = UIColor(R: 252, G: 96, B: 4, alpha: 0.9)
        
    }
    
}
