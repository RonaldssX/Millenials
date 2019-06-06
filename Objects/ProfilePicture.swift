//
//  ProfilePicture.swift
//  Millenials
//
//  Created by Ronaldo Santana on 10/04/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import UIKit

public final class PlayerPictures {
    
    public static let shared = PlayerPictures()
    
    public let defaultAdd = UIImage(named: "Player_Add")!
    public let defaultGame = UIImage(named: "Player_Default")!
    
}

class ImageController: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imagePicker = UIImagePickerController()
    weak var rootViewController: UIViewController?
    var callback: ((UIImage?) -> ())?
    
    var takePictureButton: UIButton! {
        
        didSet {
            
            self.takePictureButton.setTitle("Tirar foto", for: .normal)
            self.takePictureButton.addTarget(self, action: #selector(openCamera), for: .touchUpInside)
            
        }
        
    }
    
    var useDefaultButton: UIButton! {
        
        didSet {
            
            self.useDefaultButton.setTitle("Usar foto padrão", for: .normal)
            self.useDefaultButton.addTarget(self, action: #selector(useDefaultPicture), for: .touchUpInside)
            
        }
        
    }
    
    private var actionSheet: ActionSheet!
    
    required init(view controller: UIViewController) {
        super.init()
        
        self.rootViewController = controller
        
    }
    
    
    @objc
    func takePicture(callback: @escaping ((UIImage?) -> ())) {
         
        takePictureButton = UIButton()
        
        useDefaultButton = UIButton()
        
        self.callback = callback
        
        imagePicker.delegate = self
        
        self.actionSheet = ActionSheet()
        
        actionSheet.topButton = takePictureButton
        actionSheet.bottomButton = useDefaultButton
        
        actionSheet.display(on: rootViewController!)
        
    }
    
    @objc
    fileprivate func openCamera() {
        
        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
            
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = false
            
            actionSheet.present(imagePicker, animated: true, completion: nil)
            
            return
        }
        
    }
    
    @objc
    fileprivate func useDefaultPicture() {
        
        callback?(PlayerPictures.shared.defaultGame)
        
        actionSheet.dismissView(); actionSheet = nil
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.dismiss(animated: true, completion: { self.actionSheet.dismissView(); self.actionSheet = nil })
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let picture = resizeImage(image: info[UIImagePickerController.InfoKey.originalImage] as! UIImage)
        
        callback?(picture)
        
        picker.dismiss(animated: true, completion: { self.actionSheet.dismissView(); self.actionSheet = nil })
        
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



