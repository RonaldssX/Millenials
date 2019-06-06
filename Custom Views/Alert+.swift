//
//  Alert+.swift
//  Millenials
//
//  Created by Ronaldo Santana on 30/05/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import UIKit

class AlertController: UIViewController {
    
    private var backgroundEffect: UIVisualEffectView? {
        
        didSet {
            
            guard (self.backgroundEffect != nil) else { return }
            
            let blur = UIBlurEffect(style: .dark)
            self.backgroundEffect?.effect = blur
            
            self.backgroundEffect?.frame = view.frame
            self.backgroundEffect?.alpha = 0.0
            
        }
        
    }
    
    private var alertView: AlertView!
    
    public var alertTitle: String? {
        
        get {
            
            guard (alertView != nil),
                  (alertView!.titleLabel != nil) else { return nil }
            
            return alertView.titleLabel?.text
            
        }
        
        set {
            
            guard (alertView != nil),
                  (newValue != nil) else { return }
            
            if (alertView.titleLabel == nil) { alertView.titleLabel = UILabel() }
            
            alertView.titleLabel?.text = newValue
            
        }
        
    }
    
    public var alertMessage: String? {
        
        get {
            
            guard (alertView != nil) else { return nil }
            
            return alertView.messageLabel?.text
            
        }
        
        set {
            
            guard (alertView != nil),
                  (newValue != nil) else { return }
            
            if (alertView.messageLabel == nil) { alertView.messageLabel = UILabel() }
            
            alertView.messageLabel?.text = newValue
            
        }
        
    }
        
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.alertView = AlertView()
        
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
 

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()

    }
    
    private func configureView() {
        
        self.backgroundEffect = UIVisualEffectView()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissAlert))
        
            view.addGestureRecognizer(tap)
        
    }
    
    private func finalC() {
        
        view.addSubview(alertView)
        
        self.alertView.alpha = 0.0
        
        self.alertView.translatesAutoresizingMaskIntoConstraints = false
        
        self.alertView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        self.alertView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        
        self.alertView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true      
        
    }
    
    @objc
    public func display(on viewController: UIViewController) {
        
        let snapshot = (viewController.view.superview?.snapshotView(afterScreenUpdates: true))!
        
        view.addSubview(snapshot)
        
        finalC()
        
        view.insertSubview(backgroundEffect!, at: 1)
        
        alertView.transform = CGAffineTransform(scaleX: 0.05, y: 0.05)
        
        viewController.present(self, animated: false, completion: {
            
            UIView.animate(withDuration: 0.3, delay: 0, options: [.preferredFramesPerSecond60, .curveEaseInOut], animations: {
                
                self.alertView.transform = .identity
                self.alertView.alpha = 1.0
                self.backgroundEffect?.alpha = 1.0
                
            }, completion: nil)
            
        })
       
        
    }
    
    @objc
    public func dismissAlert() {
        
        UIView.animate(withDuration: 0.3, delay: 0, options: [.preferredFramesPerSecond60, .curveEaseInOut], animations: {
            
            self.alertView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            self.alertView.alpha = 0.0
            self.backgroundEffect?.alpha = 0.0
            
        }, completion: { _ in
            
            self.dismiss(animated: false, completion: nil)
            
        })
        
    }

}

class AlertView: UIView {
    
    fileprivate var titleLabel: UILabel? {
        
        didSet {
            
            guard (self.titleLabel != nil) else { return }
            
            self.titleLabel!.backgroundColor = .clear
            self.titleLabel!.textColor = .OffBlack
            
            self.titleLabel!.textAlignment = .center
            self.titleLabel!.numberOfLines = 1
            
            self.titleLabel!.font = UIFont.defaultFont(size: 25, weight: .semiBold)
            
            addSubview(self.titleLabel!)
            
            self.titleLabel!.translatesAutoresizingMaskIntoConstraints = false
            
            self.titleLabel!.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor).isActive = true
            self.titleLabel!.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor).isActive = true
            
            self.titleLabel!.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
            self.titleLabel!.bottomAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -20).isActive = true
            
        }
        
    }
    
    fileprivate var messageLabel: UILabel! {
        
        didSet {
            
            guard (self.messageLabel != nil) else { return }
            
            self.messageLabel.backgroundColor = .clear
            self.messageLabel.textColor = .OffBlack
            
            self.messageLabel.textAlignment = .center
            self.messageLabel.numberOfLines = 0
            
            self.messageLabel.font = UIFont.defaultFont(size: 18, weight: .regular)
            
            addSubview(self.messageLabel)
            
            self.messageLabel.translatesAutoresizingMaskIntoConstraints = false
            
            self.messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            
            self.messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
            self.messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
            
        }
        
    }
    
    fileprivate var buttonsView: UIView! {
        
        didSet {
            
            guard (self.buttonsView != nil) else { return }
            
            addSubview(self.buttonsView)
            
            self.buttonsView.translatesAutoresizingMaskIntoConstraints = false
            
            self.buttonsView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            self.buttonsView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            
            self.buttonsView.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 30).isActive = true
            self.buttonsView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
            
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = .OffWhite
        
        layer.cornerRadius = 15
        clipsToBounds = true
        
    }
    
}
