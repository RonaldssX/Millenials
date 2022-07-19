//
//  ProfilePicture.swift
//  Millenials
//
//  Created by Ronaldo Santana on 10/04/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import UIKit

public final class PlayerPictures {
    
    static let shared = PlayerPictures()
    
    let defaultAdd = UIImage(named: "Player_Add")!
    let defaultGame = UIImage(named: "Player_Default")!
    
}

final class ImageController: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imagePicker = UIImagePickerController()
    weak var rootViewController: UIViewController?
    var callback: ((UIImage?) -> ())?
    
    var takePictureButton: UIButton! {
        
        willSet { self.takePictureButton?.removeFromSuperview() }
        
        didSet {
            
            self.takePictureButton.setTitle(localized("TakePicture"), for: .normal)
            self.takePictureButton.addTarget(self, action: #selector(openCamera), for: .touchUpInside)
            
        }
        
    }
    
    var useDefaultButton: UIButton! {
        
        willSet { self.useDefaultButton?.removeFromSuperview() }
        
        didSet {
            
            self.useDefaultButton.setTitle(localized("UseDefault"), for: .normal)
            self.useDefaultButton.addTarget(self, action: #selector(useDefaultPicture), for: .touchUpInside)
            
        }
        
    }
    
    private var actionSheet: ActionSheet! {
        
        didSet {
            
            guard (self.actionSheet != nil) else { return }
            
            self.actionSheet.topButton = takePictureButton
            self.actionSheet.bottomButton = useDefaultButton
            
        }
        
    }
    
    required init(view controller: UIViewController) {
        super.init()
        
        self.rootViewController = controller
        defer {
            self.takePictureButton = UIButton()
            self.useDefaultButton = UIButton()
            self.actionSheet = ActionSheet()
        }
        
    }
    
    
    @objc
    func takePicture(callback: @escaping ((UIImage?) -> ())) {
        
        self.callback = callback
        imagePicker.delegate = self
        actionSheet.display(on: rootViewController!)
        
    }
    
    @objc
    fileprivate func openCamera() {
        #if targetEnvironment(simulator)
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        actionSheet.present(imagePicker, animated: true, completion: nil)
        return;
        #endif
        
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        actionSheet.present(imagePicker, animated: true, completion: nil)
        return;
        
        guard (UIImagePickerController.isSourceTypeAvailable(.camera)) else { return }
        
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
        actionSheet.present(imagePicker, animated: true, completion: nil)
        
    }
    
    @objc
    fileprivate func useDefaultPicture() {
        
        rootViewController?.view?.layoutSubviews()
        callback?(PlayerPictures.shared.defaultGame)
        actionSheet?.dismissView()
        actionSheet = nil
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.dismiss(animated: true) {
            self.actionSheet?.dismissView()
            self.actionSheet = nil
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let picture = resizeImage(image: info[UIImagePickerController.InfoKey.originalImage] as! UIImage)
        
        rootViewController?.view?.layoutSubviews()
        callback?(picture)
        
        picker.dismiss(animated: true) {
            self.actionSheet?.dismissView()
            self.actionSheet = nil
        }
        
    }
    
    private func resizeImage(image: UIImage) -> UIImage {
        return image
    }
    
    deinit {
        
        rootViewController = nil
        callback = nil
        actionSheet = nil
        
    }

}



