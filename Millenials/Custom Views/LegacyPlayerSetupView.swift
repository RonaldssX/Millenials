//
//  PlayerSetupView.swift
//  Millenials
//
//  Created by Ronaldo Santana on 14/04/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import UIKit

fileprivate let TextFieldIcon: UIImage = {
    if #available(iOS 13.0, macCatalyst 13.0,*) {
        let configuration = UIImage.SymbolConfiguration(textStyle: .body, scale: .medium)
        return UIImage(systemName: "pencil.circle", withConfiguration: configuration)!
    } else {
        return UIImage(named: "NameInput")!
    }
}()

class LegacyPlayerSetupView: UIView {    
    
    public weak var rootViewController: UIViewController? {
        didSet {
            
            guard (self.rootViewController != nil) else { return }
            
            backgroundColor = .clear
            self.rootViewController?.view.addSubview(self)
            addConstraints()
            
        }
    }
    
    public var playerPicture: UIImage? {
        
        didSet {
            
            guard (self.playerPicture != nil),
                  (playerPictureView != nil) else { return }
            
            playerPictureView.image = self.playerPicture
            if !(PlayerPictures.isDefaultPicture(playerPicture)) {
                playerPictureView!.layer.borderWidth = 0.0
                return
            }
            
            playerPictureView.layer.borderWidth = 3.0
            playerPictureView!.image = playerPictureView!.image?.withRenderingMode(.alwaysTemplate)
            
        }
        
    }
    public var isDefaultImage: Bool {
        
        get {
            
            guard (playerPicture != nil) else { return true }
            return (playerPicture! == PlayerPictures.defaultAdd)
            
        }
        
    }
    
    public var playerPictureView: UIImageView! {
        
        didSet {
            
            self.playerPictureView.contentMode = .scaleAspectFill
            
            self.playerPictureView.isUserInteractionEnabled = true
            self.playerPictureView.isExclusiveTouch = true
            
            addSubview(self.playerPictureView)
            
            self.playerPictureView.translatesAutoresizingMaskIntoConstraints = false
            
            self.playerPictureView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: (isiPad ? 30 : 0)).isActive = true
            
            self.playerPictureView.topAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
            self.playerPictureView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30).isActive = true
            
            self.playerPictureView.heightAnchor.constraint(equalTo: self.playerPictureView.widthAnchor).isActive = true
            
            self.playerPictureView.backgroundColor = .clear
            self.playerPictureView.tintColor = UIColor().randomPlayerColor()
            
            self.playerPictureView.layer.borderWidth = 3
            self.playerPictureView.layer.borderColor = self.playerPictureView.tintColor.withAlphaComponent(0.95).cgColor
            
            
            self.playerPictureView.rounded()
            
        }
       
        
    }
    
    public var playerTextField: FlatTextField! {
        
        didSet {
            
            self.playerTextField.delegate = rootViewController as! PlayersVC
            
            self.playerTextField.isExclusiveTouch = true
            
            self.playerTextField.attributedPlaceholder = NSAttributedString(string: localized("Name"), attributes: [key.foregroundColor: UIColor.OffWhite.withAlphaComponent(0.5)])
            self.playerTextField.textAlignment = .center
            
            self.playerTextField.keyboardAppearance = .dark
            self.playerTextField.autocorrectionType = .no // <- esse merda que ta causando o leaking
            self.playerTextField.autocapitalizationType = .words
            
            self.playerTextField.font = .defaultFont(size: 16, weight: .light)
            self.playerTextField.icon = TextFieldIcon
            
            self.playerTextField.tintColor = UIColor.OffWhite.withAlphaComponent(0.5)
            
            self.playerTextField.backgroundColor = .clear
            self.playerTextField.textColor = .OffWhite
            
            self.playerTextField.layer.cornerRadius = 12
            self.playerTextField.clipsToBounds = true
            
            addSubview(self.playerTextField)
            
            self.playerTextField.translatesAutoresizingMaskIntoConstraints = false
            
            self.playerTextField.leadingAnchor.constraint(equalTo: (isiPad ? centerXAnchor : playerPictureView.trailingAnchor), constant: (isiPad ? 0 : 15)).isActive = true
            
            self.playerTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
            
            self.playerTextField.centerYAnchor.constraint(equalTo: playerPictureView.centerYAnchor).isActive = true
            self.playerTextField.heightAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true
            
        }
        
    }
    
    private func addConstraints() {
        
        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo: superview!.leadingAnchor, constant: 20).isActive = true
        trailingAnchor.constraint(equalTo: superview!.trailingAnchor).isActive = true
        heightAnchor.constraint(equalTo: superview!.heightAnchor, multiplier: 1/4).isActive = true
        
    }
    
    deinit {
        
        playerPictureView = nil
        playerTextField = nil
        
    }
    
}


fileprivate let colorsArray = [UIColor.PlayerColors.shared.blue,
                               UIColor.PlayerColors.shared.green,
                               UIColor.PlayerColors.shared.red,
                               UIColor.PlayerColors.shared.grey,
                               UIColor.PlayerColors.shared.yellow,
                               UIColor.PlayerColors.shared.orange,
                               UIColor.PlayerColors.shared.darkblue,
                               UIColor.PlayerColors.shared.lightgreen]

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
        
        static let shared = PlayerColors()
        
        let blue = UIColor(R: 52, G: 152, B: 219, alpha: 1.0)
        let green = UIColor(R: 46, G: 204, B: 113, alpha: 1.0)
        let red = UIColor(R: 231, G: 76, B: 60, alpha: 1.0)
        let grey = UIColor(R: 127, G: 140, B: 141, alpha: 1.0)
        let yellow = UIColor(R: 241, G: 196, B: 15, alpha: 1.0)
        let orange = UIColor(R: 230, G: 126, B: 34, alpha: 1.0)
        
        let darkblue = UIColor(R: 52, G: 73, B: 94, alpha: 1.0)
        let lightgreen = UIColor(R: 26, G: 188, B: 156, alpha: 1.0)
        
    }
    
}

