//
//  Alert+.swift
//  Millenials
//
//  Created by Ronaldo Santana on 30/05/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import UIKit

public class AlertController: UIViewController, NotificationProtocol {
    
    internal var backgroundEffect: UIVisualEffectView? {
        
        didSet {
            
            guard (self.backgroundEffect != nil) else { return }
            
            self.backgroundEffect!.isUserInteractionEnabled = false
            
            let blur = UIBlurEffect(style: .dark)
            self.backgroundEffect?.effect = blur
            
            self.backgroundEffect?.frame = view.frame
            self.backgroundEffect?.alpha = 0.0
            
        }
        
    }
    
    internal var initialStatusBar: Bool = !UIApplication.shared.isStatusBarHidden
    
    internal var dismissGesture: UITapGestureRecognizer!
    
    var alertView: AlertView! {
        
        didSet {
            
            guard (self.alertView != nil) else { return }
            
            self.alertView.isUserInteractionEnabled = true
            self.alertView.translatesAutoresizingMaskIntoConstraints = false
            
            self.alertView.messageLabel = UILabel()
            self.alertView.titleLabel = UILabel()
            
            self.alertView.buttonsView = UIView()
            
        }
        
    }
    
    var alertTitle: String? {
        
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
    
    var alertMessage: String? {
        
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
    
    var leftButton: UIButton? {
        
        get { return alertView.button1 }
        
        set { alertView.button1 = newValue }
        
    }
    
    var rightButton: UIButton? {
        
        get { return alertView.button2 }
        
        set { alertView.button2 = newValue }
        
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        defer { self.alertView = AlertView() }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        modalPresentationStyle = .overFullScreen

    }
    
    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        backgroundEffect?.frame = view.frame
        
    }
    
    internal func configureView() {
        
        view.isUserInteractionEnabled = true
        self.backgroundEffect = UIVisualEffectView()
        self.dismissGesture = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        
    }
    
    internal func addConstraints() {
        
        view.addSubview(alertView)
        
        self.alertView.alpha = 0.0
        
        self.alertView.translatesAutoresizingMaskIntoConstraints = false
        
        if (isiPad) {
            
            self.alertView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2).isActive = true
            self.alertView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            
        } else {
        
            self.alertView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
            self.alertView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
            
        }
        
            self.alertView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true        
        
    }
    
    func display(on viewController: UIViewController) {
        
        alertView.configure()
        
        if (alertView.buttons.count != 2) { view.addGestureRecognizer(dismissGesture) }
        
        var snapshot = (viewController.view.superview?.superview?.superview?.snapshotView(afterScreenUpdates: true))
        
            /* o que NĀO se deve fazer */
        if (snapshot == nil) { snapshot = (viewController.view.superview?.superview?.snapshotView(afterScreenUpdates: true)) }
        if (snapshot == nil) { snapshot = (viewController.view.superview?.snapshotView(afterScreenUpdates: true)) }
        
        view.addSubview(snapshot!)
        addConstraints()
        view.insertSubview(backgroundEffect!, at: 1)
        alertView.transform = CGAffineTransform(scaleX: 0.05, y: 0.05)
        
        viewController.present(self, animated: false, completion: {
            
            UIView.animate(withDuration: 0.3, delay: 0, options: [.preferredFramesPerSecond60, .curveEaseInOut], animations: {
                
                self.alertView.transform = .identity
                self.alertView.alpha = 1.0
                self.backgroundEffect?.alpha = 1.0
                hideStatusBar()
                
            })
        })
    }
    
    @objc
    func dismissView() {
        
        UIView.animate(withDuration: 0.3, delay: 0, options: [.preferredFramesPerSecond60, .curveEaseInOut], animations: {
            
            self.alertView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            self.alertView.alpha = 0.0
            self.backgroundEffect?.alpha = 0.0
            
            if (self.initialStatusBar) { showStatusBar() }
            
        }, completion: { _ in
            
            self.dismiss(animated: false, completion: nil)
            
        })
        
    }

    @nonobjc
    func dismissViewBlock(completionHandler: @escaping () -> ()) {
        
        UIView.animate(withDuration: 0.3, delay: 0, options: [.preferredFramesPerSecond60, .curveEaseInOut], animations: {
            
            self.alertView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            self.alertView.alpha = 0.0
            self.backgroundEffect?.alpha = 0.0
            
            if (self.initialStatusBar) { showStatusBar() }
            
        }, completion: { _ in
            
            self.dismiss(animated: false, completion: { completionHandler() })
            
        })
        
    }
    
}


extension AlertController: UIGestureRecognizerDelegate {
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        if (touch.view == alertView) { return false }
        
        return true
        
    }
    
}

class AlertView: UIView, NotificationViewProtocol {
    
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
            
            self.titleLabel!.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
            self.titleLabel!.bottomAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -15).isActive = true
            
        }
        
    }
    
    fileprivate var messageLabel: UILabel! {
        
        didSet {
            
            guard (self.messageLabel != nil) else { return }
            
            self.messageLabel.backgroundColor = .clear
            self.messageLabel.textColor = .OffBlack
            
            self.messageLabel.textAlignment = .center
            self.messageLabel.numberOfLines = 0
            
            self.messageLabel.font = UIFont.defaultFont(size: 20, weight: .regular)
            
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
            
            self.buttonsView.isUserInteractionEnabled = true
            
            addSubview(self.buttonsView)
            
            self.buttonsView.translatesAutoresizingMaskIntoConstraints = false
            
            self.buttonsView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            self.buttonsView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            
            self.buttonsView.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 30).isActive = true
            self.buttonsView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            
            self.buttonsView.heightAnchor.constraint(equalToConstant: 50).isActive = true
            
        }
        
    }
    
    fileprivate var button1: UIButton? {
        
        didSet {
            
            guard (self.button1 != nil) else { return }
            
            buttonsView.addSubview(self.button1!)
            
            self.button1?.translatesAutoresizingMaskIntoConstraints = false
            
            self.button1?.leadingAnchor.constraint(equalTo: buttonsView.leadingAnchor, constant: 15).isActive = true
            
            self.button1?.topAnchor.constraint(equalTo: buttonsView.topAnchor, constant: 5).isActive = true
            self.button1?.bottomAnchor.constraint(equalTo: buttonsView.bottomAnchor, constant: -5).isActive = true
            
            buttons.append(self.button1!)
            
        }
        
    }
    
    fileprivate var button2: UIButton? {
        
        didSet {
            
            guard (self.button2 != nil) else { return }
            
            buttonsView.addSubview(self.button2!)
            
            self.button2?.translatesAutoresizingMaskIntoConstraints = false
            
            self.button2?.trailingAnchor.constraint(equalTo: buttonsView.trailingAnchor, constant: -15).isActive = true
            
            self.button2?.topAnchor.constraint(equalTo: buttonsView.topAnchor, constant: 5).isActive = true
            self.button2?.bottomAnchor.constraint(equalTo: buttonsView.bottomAnchor, constant: -5).isActive = true
            
            buttons.append(self.button2!)
            
        }
        
    }
    
    internal var buttons: [UIButton] = []
    
    public func configure() {
        
        isUserInteractionEnabled = true
        
        if (titleLabel?.text == ""), (titleLabel?.text == nil) {
            titleLabel?.removeFromSuperview()
            messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        }
        
        if (buttons.count == 2) {
            
            button1?.trailingAnchor.constraint(equalTo: buttonsView.centerXAnchor, constant: -7.5).isActive = true
            
            button2?.widthAnchor.constraint(equalTo: button1!.widthAnchor).isActive = true
            button2?.leadingAnchor.constraint(equalTo: buttonsView.centerXAnchor, constant: 7.5).isActive = true
            
        } else {
            
            button1?.trailingAnchor.constraint(equalTo: buttonsView.trailingAnchor, constant: -15).isActive = true
            
        }
        
        buttons.forEach({ button in
            
            button.backgroundColor = .LightPurple
            button.clipsToBounds = true
            button.layer.cornerRadius = 15
            button.isExclusiveTouch = true
            
            button.tag = 6969
            
            button.titleLabel?.font = .defaultFont(size: (buttons.count == 2 ? 15 : 20), weight: .medium)
            button.setTitleColor(.OffWhite, for: .normal)
            
        })
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = .OffWhite
        
        layer.cornerRadius = 15
        clipsToBounds = true
        
    }
    
}
