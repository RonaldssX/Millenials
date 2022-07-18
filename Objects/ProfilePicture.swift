//
//  ProfilePicture.swift
//  Millenials
//
//  Created by Ronaldo Santana on 10/04/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import UIKit


class ImageController: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imagePicker = UIImagePickerController()
    var rootViewController: UIViewController?
    var callback: ((UIImage) -> ())?
    
    private var alertView: PlayerPictureAlert!
    
    required init(view controller: UIViewController) {
        super.init()
        
        self.rootViewController = controller
        
    }
    
    @objc
    func takePicture(callback: @escaping ((UIImage) -> ())) {
        
        self.callback = callback
        
        self.alertView = PlayerPictureAlert(viewController: rootViewController!, controller: self)
            alertView.alertType = .ActionSheet
        
        imagePicker.delegate = self
        
        
    }
    
    @objc
    fileprivate func openCamera() {
        
        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
            
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = false
            
            alertView.toggleView()
            
            rootViewController!.present(imagePicker, animated: true, completion: nil)
            
            return
        }
        
        if (UIImagePickerController.isSourceTypeAvailable(.photoLibrary)) {
            
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            
            rootViewController!.present(imagePicker, animated: true, completion: nil)
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let picture = resizeImage(image: info[UIImagePickerController.InfoKey.originalImage] as! UIImage)
        
        callback?(picture)
        
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    private func resizeImage(image: UIImage) -> UIImage {
        
        return image
        
    }
    

}

fileprivate class PlayerPictureAlert: AlertView {
    
    
    convenience init(viewController: UIViewController, controller: ImageController) {
        self.init(alert: .ActionSheet, root: viewController)
        
        self.imageController = controller
        
        loadPlayerPictureAlert()            
        
        
    }
    
    var imageController: ImageController!
    
    public var takePictureButton: UIButton! {
        
        didSet {
            
            self.takePictureButton.addTarget(imageController, action: #selector(imageController.openCamera), for: .touchUpInside)
            
            self.takePictureButton.setTitle("Tirar foto", for: .normal)
            self.takePictureButton.backgroundColor = UIColor.View.Background.answersColor
            self.takePictureButton.layer.cornerRadius = 20
            self.takePictureButton.clipsToBounds = true
            
        }
        
    }
    
    public var useDefaultButton: UIButton! {
        
        didSet {
            
            self.useDefaultButton.addTarget(self, action: #selector(toggleView), for: .touchUpInside)
            
            self.useDefaultButton.setTitle("Usar foto padrão", for: .normal)
            
            self.useDefaultButton.backgroundColor = UIColor.View.Background.answersColor
            
            self.useDefaultButton.layer.cornerRadius = 20
            self.useDefaultButton.clipsToBounds = true
            
        }
        
        
    }
    
    private func loadPlayerPictureAlert() {
        
        backgroundColor = UIColor.View.Background.questionVCColor
        
        heightAnchor.constraint(equalToConstant: rootViewController.view.frame.height / 4).isActive = true
        
        layoutIfNeeded()
        
        bottomConstraint = bottomAnchor.constraint(equalTo: rootViewController.view.bottomAnchor, constant: frame.height)        
        
        
        self.takePictureButton = UIButton()
        
        addSubview(takePictureButton)
        
        
        takePictureButton.translatesAutoresizingMaskIntoConstraints = false
        
        takePictureButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        takePictureButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        
        takePictureButton.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        
        
        self.useDefaultButton = UIButton()
        
        addSubview(useDefaultButton)
        
        
        useDefaultButton.translatesAutoresizingMaskIntoConstraints = false
        
        useDefaultButton.leadingAnchor.constraint(equalTo: takePictureButton.leadingAnchor).isActive = true
        useDefaultButton.trailingAnchor.constraint(equalTo: takePictureButton.trailingAnchor).isActive = true
        
        useDefaultButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
        useDefaultButton.topAnchor.constraint(equalTo: takePictureButton.bottomAnchor, constant: 30).isActive = true
        
        useDefaultButton.heightAnchor.constraint(equalTo: takePictureButton.heightAnchor).isActive = true
       
        
    }
}


