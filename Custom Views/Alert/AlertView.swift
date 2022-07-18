//
//  AlertView.swift
//  Millenials
//
//  Created by Ronaldo Santana on 14/04/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import UIKit

public enum AlertTypes {
    
    case Alert
    case ActionSheet
    
}


class AlertView: UIView {
   
    internal var bottomConstraint: NSLayoutConstraint! {
        
        didSet {
            
            if (!self.bottomConstraint.isActive) {
                
                self.bottomConstraint.isActive.toggle()
                isLoaded.toggle()
                
            }
            
        }
        
    }
    
    internal var isLoaded: Bool! = false {
        
        didSet {
            
            toggleView()
            
        }
        
    }
    
    
    
    private var motionBlur: UIVisualEffectView! {
        
        didSet {
            
            self.motionBlur.translatesAutoresizingMaskIntoConstraints = false
            
            self.motionBlur.alpha = 0.0
            
            self.motionBlur.frame = rootViewController.view.frame
            
            self.rootViewController.view.addSubview(self.motionBlur)
            
            self.tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleView))
            
        }
        
    }
    
    private var tapGesture: UITapGestureRecognizer! {
        
        didSet {
            
            self.tapGesture.numberOfTapsRequired = 1
            self.tapGesture.numberOfTouchesRequired = 1
            
        }
        
    }
    
    public var rootViewController: UIViewController! {
        
        didSet {
            
            motionBlur = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
            
        }
        
    }
    
    internal var alertWarningLabel: UILabel? {
        
        didSet {
            
            self.alertWarningLabel?.text = "Aviso!"
            
            self.alertWarningLabel?.textColor = .white
            self.alertWarningLabel?.backgroundColor = backgroundColor
            
            addSubview(self.alertWarningLabel!)
            
            self.alertMessageLabel?.translatesAutoresizingMaskIntoConstraints = false
            
            self.alertWarningLabel?.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            self.alertWarningLabel?.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            
            self.alertWarningLabel?.topAnchor.constraint(equalTo: topAnchor).isActive = true
            self.alertWarningLabel?.heightAnchor.constraint(equalToConstant: 60).isActive = true
            
        }
        
    }
    
    internal var alertMessageLabel: UILabel? {
        
        didSet {
            
            self.alertMessageLabel?.textColor = .white
            self.alertMessageLabel?.backgroundColor = backgroundColor
            
            addSubview(self.alertMessageLabel!)
            
            self.alertMessageLabel?.translatesAutoresizingMaskIntoConstraints = false
            
            self.alertMessageLabel?.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
            self.alertMessageLabel?.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
            
            self.alertMessageLabel?.topAnchor.constraint(equalTo: self.alertWarningLabel!.bottomAnchor, constant: 30).isActive = true
            self.alertMessageLabel?.heightAnchor.constraint(equalToConstant: bounds.height / 3).isActive = true
            
        }
        
    }
    
    
    public var alertType: AlertTypes! {
     
        didSet {
            
            switch self.alertType! {
                
            case .Alert:
                
                rootViewController.view.addSubview(self)
                
                translatesAutoresizingMaskIntoConstraints = false
                
                layer.cornerRadius = 20
                clipsToBounds = true
                
                leadingAnchor.constraint(equalTo: rootViewController.view.leadingAnchor, constant: 50).isActive = true
                trailingAnchor.constraint(equalTo: rootViewController.view.trailingAnchor, constant: -50).isActive = true
                
                break
                
            case .ActionSheet:
                
                rootViewController.view.addSubview(self)
                
                translatesAutoresizingMaskIntoConstraints = false
                
                layer.cornerRadius = 20
                clipsToBounds = true
                
                leadingAnchor.constraint(equalTo: rootViewController.view.leadingAnchor, constant: 10).isActive = true
                trailingAnchor.constraint(equalTo: rootViewController.view.trailingAnchor, constant: -10).isActive = true
                
                break
                
            }
        
    }
        
    }
    
    public var alertMessage: String? {
        
        didSet {
            
            guard (alertType == .Alert) else { return }
            
            alertWarningLabel = UILabel()
            
            alertMessageLabel = UILabel()
            alertMessageLabel?.text = self.alertMessage
            
        }
        
    }
    
    public var alertButtons: [AlertButton]? {
        
        didSet {
            
            guard (0...2 ~= self.alertButtons!.count) else {
                
                self.alertButtons = []
                
                return
                
            }
            
            guard (alertType == .Alert) else { return }
            
            for button in self.alertButtons! {
                
                button.setTitleColor(.white, for: .normal)
                button.backgroundColor = nil
                
                button.layer.cornerRadius = 12
                button.clipsToBounds = true
                
                addSubview(button)
                
            }
            
            let button1 = self.alertButtons!.first!
            
                button1.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
            
                button1.topAnchor.constraint(equalTo: (alertMessageLabel?.bottomAnchor)!, constant: 30).isActive = true
                button1.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30).isActive = true
            
            
            guard let button2 = self.alertButtons!.last else {
                
                button1.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
                
                return
                
            }
            
                button1.trailingAnchor.constraint(equalTo: button2.leadingAnchor).isActive = true
            
                button2.widthAnchor.constraint(equalTo: button1.widthAnchor).isActive = true
                button2.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
            
                button2.topAnchor.constraint(equalTo: button1.topAnchor).isActive = true
                button2.bottomAnchor.constraint(equalTo: button1.bottomAnchor).isActive = true
            
        }
        
    }
    
    convenience init(alert type: AlertTypes, root viewController: UIViewController?) {
        self.init()
        
        defer {
        
        self.rootViewController = viewController
        self.alertType = type            
            
        }
        
    }
    
    
    internal func animateActionSheet() {
        
        func show() {
            
            bottomConstraint.constant = -10
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: 1, options: [.preferredFramesPerSecond60, .curveEaseInOut], animations: {
                
                self.rootViewController.view.layoutIfNeeded()
                
                self.motionBlur.alpha = 1.0
                
                self.rootViewController.toggleNavigationBar()
                
            }, completion: {(completed) in                
                
                self.rootViewController.view.addGestureRecognizer(self.tapGesture)
                
            })
            
        }
        
        func hide() {
            
            bottomConstraint.constant = frame.height
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: 1, options: [.preferredFramesPerSecond60, .curveEaseInOut], animations: {
                
                self.motionBlur.alpha = 0.0
                
                self.rootViewController.view.layoutIfNeeded()
                
                self.rootViewController.toggleNavigationBar()
                
            }, completion: {(completed) in
                
                self.rootViewController.view.removeGestureRecognizer(self.tapGesture)
                
                self.removeFromSuperview()
                
            })           
            
        }
        
        if (bottomConstraint == nil || bottomConstraint.constant != -10) {            
            
            rootViewController.view.layoutIfNeeded()
            
             show()
            
            return
            
        }
        
        hide()
        
        return
        
    }
    
    internal func animateAlert() {
        
        func show() {
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: 1, options: [.preferredFramesPerSecond60, .curveEaseInOut], animations: {
                
                
                
            }, completion: {(completed) in
                
                
            })
            
            
        }
        
        
        func hide() {
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: 1, options: [.preferredFramesPerSecond60, .curveEaseInOut], animations: {
                
                
                
            }, completion: {(completed) in
                
                self.removeFromSuperview()
                
            })
            
        }
        
    }
    
    @objc 
    public func displayAlert() {
        
        animateAlert()
        
    }
    
    
    @objc
    public func toggleView() {
        
        switch alertType! {
            
        case .Alert:
            
            animateAlert()
            
        case .ActionSheet:
            
            animateActionSheet()
            
        }
        
    }
    
    override func removeFromSuperview() {
        super.removeFromSuperview()
        
        self.motionBlur.removeFromSuperview()
        
    }

}
