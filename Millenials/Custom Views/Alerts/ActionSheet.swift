//
//  ActionSheet.swift
//  Millenials
//
//  Created by Ronaldo Santana on 30/05/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import UIKit

public class ActionSheet: UIViewController, NotificationProtocol {
    
    internal var backgroundEffect: UIVisualEffectView? {
        
        didSet {
            
            guard (self.backgroundEffect != nil) else { return }
            
            let blur = UIBlurEffect(style: .dark)
            self.backgroundEffect?.effect = blur
            
            self.backgroundEffect?.frame = view.frame
            self.backgroundEffect?.alpha = 0.0
            
        }
        
    }
    
    internal var initialStatusBar: Bool = !UIApplication.shared.isStatusBarHidden
    
    private var actionSheetConstraint: NSLayoutConstraint?
    var actionSheetView: ActionSheetView!
    
    var topButton: UIButton? {
        
        get { return actionSheetView.button1 }
        
        set { actionSheetView.button1 = newValue }
        
    }
    
    var bottomButton: UIButton? {
        
        get { return actionSheetView.button2 }
        
        set { actionSheetView.button2 = newValue }
        
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.actionSheetView = ActionSheetView()
        
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
        
        self.backgroundEffect = UIVisualEffectView()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        
        view.addGestureRecognizer(tap)
        
    }
    
    internal func addConstraints() {
        
        view.addSubview(actionSheetView)
        
        actionSheetView.configure()
        
        actionSheetView.translatesAutoresizingMaskIntoConstraints = false
        
        actionSheetView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        actionSheetView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        
        actionSheetView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25).isActive = true
        
        actionSheetView.layoutIfNeeded()
        
        actionSheetConstraint = actionSheetView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: actionSheetView.bounds.height)
        actionSheetConstraint!.isActive = true
        
        actionSheetView.layoutIfNeeded()
        
    }
    
    func display(on viewController: UIViewController) {
        
        let snapshot = (viewController.view.superview?.superview?.superview?.snapshotView(afterScreenUpdates: true))!
        
        view.addSubview(snapshot)
        addConstraints()
        view.insertSubview(backgroundEffect!, at: 1)
        
        viewController.present(self, animated: false, completion: {
            
            self.actionSheetConstraint?.constant = -10
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 2, initialSpringVelocity: 1, options: [.preferredFramesPerSecond60, .curveEaseInOut, .allowUserInteraction], animations: {
                
                self.backgroundEffect?.alpha = 1.0
                self.view.layoutIfNeeded()
                
                hideStatusBar()
                
            })
        })
    }
    
    @objc
    func dismissView() {
        
        actionSheetConstraint?.constant = actionSheetView.bounds.height
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 2, initialSpringVelocity: 1, options: [.preferredFramesPerSecond60, .curveEaseInOut, .allowUserInteraction], animations: {
            
            self.backgroundEffect?.alpha = 0.0
            self.view.layoutIfNeeded()
            
            if (self.initialStatusBar) { showStatusBar() }
            
        }, completion: { _ in
        
            self.dismiss(animated: false, completion: nil)
            
        })
        
    }
    
    @nonobjc
    func dismissViewBlock(completionHandler: @escaping () -> ()) {
        
        actionSheetConstraint?.constant = actionSheetView.bounds.height
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 2, initialSpringVelocity: 1, options: [.preferredFramesPerSecond60, .curveEaseInOut, .allowUserInteraction], animations: {
            
            self.backgroundEffect?.alpha = 0.0
            self.view.layoutIfNeeded()
            
            if (self.initialStatusBar) { showStatusBar() }
            
        }, completion: { _ in
            
            self.dismiss(animated: false, completion: nil)
            completionHandler()
            
        })
    }

}

extension ActionSheet: UIGestureRecognizerDelegate {
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        return !(touch.view == actionSheetView)
        
    }
    
}

class ActionSheetView: UIView, NotificationViewProtocol {
    
    fileprivate var button1: UIButton? {
        
        willSet { self.button1?.removeFromSuperview() }
        
        didSet {
            
            guard (self.button1 != nil) else { return }
            
                addSubview(self.button1!)
            
                self.button1?.translatesAutoresizingMaskIntoConstraints = false
            
                self.button1?.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
                self.button1?.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
            
                self.button1?.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
            
                buttons.append(self.button1!)
            
        }
        
    }
    
    fileprivate var button2: UIButton? {
        
        willSet { self.button2?.removeFromSuperview() }
        
        didSet {
            
            guard (self.button2 != nil) else { return }
            
                addSubview(self.button2!)
            
                self.button2?.translatesAutoresizingMaskIntoConstraints = false
            
                self.button2?.leadingAnchor.constraint(equalTo: button1!.leadingAnchor).isActive = true
                self.button2?.trailingAnchor.constraint(equalTo: button1!.trailingAnchor).isActive = true
            
                self.button2?.topAnchor.constraint(equalTo: button1!.bottomAnchor, constant: 20).isActive = true
            
                self.button2?.heightAnchor.constraint(equalTo: button1!.heightAnchor).isActive = true
            
                self.button2?.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
            
            
                buttons.append(self.button2!)
            
        }
        
    }
    
    internal var buttons: [UIButton] = []
    
    public func configure() {
        
        buttons.forEach({ button in
            
            button.layer.cornerRadius = 12
            button.clipsToBounds = true
            
            button.isExclusiveTouch = true
            
            button.titleLabel?.font = UIFont.defaultFont(size: 20, weight: .semiBold)
            
            button.setTitleColor(.OffWhite, for: .normal)
            button.backgroundColor = .LightPurple
            
        })
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = .Purple
        
        layer.cornerRadius = 15
        clipsToBounds = true
        
    }
    
}
