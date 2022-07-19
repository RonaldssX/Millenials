//
//  Alert.swift
//  Millenials
//
//  Created by Ronaldo Santana on 22/04/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import UIKit

class Alert: UIViewController {
    
    internal var isLoaded: Bool = false
    
    internal var alertView: UIView! {
        
        didSet {
            
            self.alertView.layer.cornerRadius = 12
            self.alertView.clipsToBounds = true
            
        }
        
    }
    
    internal var alertTitleLabel: UILabel! {
        
        didSet {
            
        }
        
    }
    
    internal var alertMessageLabel: UILabel! {
        
        didSet {
            
        }
        
    }
    
    private var buttons: [UIButton]? {
        
        didSet {
            
            guard (self.buttons != nil) else { return }
            
        }
        
    }
    
    public weak var rootViewController: UIViewController? {
        
        didSet {
            
            guard (self.rootViewController != nil) else { return }
            
        }
        
    }
    
    convenience init(buttons: [UIButton]? = nil, message: String? = nil) {
        self.init()
        
        self.buttons = buttons
        
        
    }
    
    @objc
    internal func loadAlert() {
        
        view.isOpaque = false
        view.backgroundColor = .clear
        
        alertView = UIView()
        
        alertView.layer.cornerRadius = 12
        alertView.clipsToBounds = true
        
        alertView.backgroundColor = .LightMidnightBlue
        
        view.addSubview(alertView)
        
        alertView.translatesAutoresizingMaskIntoConstraints = false
        
        alertView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        alertView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        alertView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        alertView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100).isActive = true
        
        alertView.layoutIfNeeded()
        
        
    }
    
    @objc
    public func display() {
        
        
        
    }
    
}

class ActionSheet: UIViewController {
    
    internal var isLoaded: Bool = false
    
    internal var actionSheetView: UIView! {
        
        didSet {
            
            self.actionSheetView.layer.cornerRadius = 12
            self.actionSheetView.clipsToBounds = true
            
            self.actionSheetView.backgroundColor = .LightMidnightBlue
            
            view.addSubview(self.actionSheetView)
            
            self.actionSheetView.translatesAutoresizingMaskIntoConstraints = false
            
            self.actionSheetView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
            self.actionSheetView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
            
            self.actionSheetView.heightAnchor.constraint(equalToConstant: view.frame.height / 4).isActive = true
            
            self.actionSheetView.layoutIfNeeded()
            
            actionSheetConstraint = self.actionSheetView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: self.actionSheetView.frame.height)
            
            self.actionSheetView.layoutIfNeeded()
            
        }
        
    }
    
    internal var actionSheetConstraint: NSLayoutConstraint! {
        
        didSet {
            
            self.actionSheetConstraint.isActive = true
            
        }
        
    }
    
    internal lazy var backgroundBlur: UIVisualEffectView! = {
        
        var visualEffect: UIVisualEffectView
        
        if #available(iOS 10.0, *) {
            
            visualEffect = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
            
        } else {
         
            visualEffect = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
            
        }       
        
            visualEffect.translatesAutoresizingMaskIntoConstraints = false
            visualEffect.alpha = 0.0
        
        return visualEffect
        
    }()
    
    public var buttons: [UIButton] = []
    
    public weak var rootViewController: UIViewController? {
        
        didSet {
            
            guard (self.rootViewController != nil) else { return }
            
            modalPresentationStyle = .overCurrentContext
            
            backgroundBlur.frame = (self.rootViewController?.navigationController?.view.bounds)!
            
            self.rootViewController?.view.addSubview(backgroundBlur)
            
        }
        
    }
    
    convenience init(buttons: [UIButton]) {
        self.init()
        
        self.buttons = buttons
        
        loadActionSheet()
        
    }
    
    @objc
    internal func loadActionSheet() {
        
        view.isOpaque = false 
        
        view.backgroundColor = .clear
        
        actionSheetView = UIView()
        
        guard (buttons.count != 0) else { isLoaded = true; return }
        
        view.layoutIfNeeded()
        
        for button in buttons {           
            
            button.layer.cornerRadius = 12
            button.clipsToBounds = true
            
            button.setTitleColor(.OffWhite, for: .normal)
            button.backgroundColor = .MidnightBlue
            
            actionSheetView.addSubview(button)
            
            button.translatesAutoresizingMaskIntoConstraints = false             
            
            button.leadingAnchor.constraint(equalTo: actionSheetView.leadingAnchor, constant: 20).isActive = true
            button.trailingAnchor.constraint(equalTo: actionSheetView.trailingAnchor, constant: -20).isActive = true
            
        }
        
        let button1 = buttons.first!
        
        button1.topAnchor.constraint(equalTo: actionSheetView.topAnchor, constant: 20).isActive = true
        
        guard (buttons.count == 2) else {
            
            button1.bottomAnchor.constraint(equalTo: actionSheetView.bottomAnchor, constant: -20).isActive = true
            
            isLoaded = true 
            
            return
            
        }
        
        let button2 = buttons.last!
        
        button2.topAnchor.constraint(equalTo: (button1.bottomAnchor), constant: 20).isActive = true
        button2.bottomAnchor.constraint(equalTo: actionSheetView.bottomAnchor, constant: -20).isActive = true
        
        button2.heightAnchor.constraint(equalTo: button1.heightAnchor).isActive = true
        
        isLoaded = true
        
    }
    
    @objc
    public func display() {
        
        guard (isLoaded) else { loadActionSheet(); display(); return }
        
        guard (actionSheetConstraint != nil),
               (actionSheetConstraint.constant != -10) else {
                
                view.isUserInteractionEnabled = false
            
                actionSheetConstraint.constant = actionSheetView.frame.height
                
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 2, initialSpringVelocity: 1, options: [.preferredFramesPerSecond60, .curveEaseInOut], animations: {
                    
                    self.view.layoutIfNeeded()
                    self.backgroundBlur.alpha = 0.0
                    
                    
                    if (!(self.rootViewController is IntroVC)) {
                    
                    self.rootViewController?.navigationController?.setNavigationBarHidden(false, animated: true)
                        
                    }
                    
                    
                }, completion: {[weak self](completed) in
                    
                    self?.dismiss(animated: false, completion: nil)
                
                })
            
            
            return
        }
        
        rootViewController!.present(self, animated: false, completion: {[unowned self] in
            
            self.actionSheetConstraint.constant = -10
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 2, initialSpringVelocity: 1, options: [.preferredFramesPerSecond60, .curveEaseInOut], animations: {
                
                self.view.layoutIfNeeded()
                self.backgroundBlur.alpha = 1.0
                
                if (!(self.rootViewController is IntroVC)) {
                    
                    self.rootViewController?.navigationController?.setNavigationBarHidden(true, animated: true)
                    
                }
                
            }, completion: {[unowned self](completed) in
                
                self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.display)))
                
            })
            
        })
        
        
    }
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag, completion: completion)
        
        self.backgroundBlur.alpha = 0.0
        self.backgroundBlur.removeFromSuperview()
        //self.rootViewController?.toggleNavigationBar()
        
    }
    
    
}
