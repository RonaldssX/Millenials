//
//  AboutMeVC.swift
//  Millenials
//
//  Created by Ronaldo Santana on 07/12/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import UIKit

fileprivate let gradientColorsArray: [UIColor] = [UIColor(R: 101, G: 78, B: 163, alpha: 1),
                                                  UIColor(R: 234, G: 175, B: 200, alpha: 1)]

final class AboutMeVC: UIViewController {
    
    private var backgroundGradientView: UIView! {
        
        willSet { self.backgroundGradientView?.removeFromSuperview() }
        
        didSet {
            
            guard (self.backgroundGradientView != nil) else { return }
            
            self.backgroundGradientView.gradient(colors: gradientColorsArray)
            
            view.addSubview(self.backgroundGradientView)
            self.backgroundGradientView.translatesAutoresizingMaskIntoConstraints = false
            self.backgroundGradientView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            self.backgroundGradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            self.backgroundGradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            self.backgroundGradientView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/3).isActive = true
            
        }
        
    }
    
    private var ronaldssImageView: UIImageView! {
        
        willSet { self.ronaldssImageView?.removeFromSuperview() }
        
        didSet {
            
            guard (self.ronaldssImageView != nil) else { return }
            
            self.ronaldssImageView.clipsToBounds = true
            self.ronaldssImageView.isUserInteractionEnabled = false
            
            view.addSubview(self.ronaldssImageView)
            self.ronaldssImageView.translatesAutoresizingMaskIntoConstraints = false
            self.ronaldssImageView.topAnchor.constraint(equalTo: view.safeGuide.topAnchor, constant: 30).isActive = true
            self.ronaldssImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            self.ronaldssImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3).isActive = true
            self.ronaldssImageView.heightAnchor.constraint(equalTo: self.ronaldssImageView.widthAnchor).isActive = true
            
        }
        
    }
    
    private var myNameLabel: UILabel! {
        
        willSet { self.myNameLabel?.removeFromSuperview() }
        
        didSet {
            
            guard (self.myNameLabel != nil) else { return }
            
            self.myNameLabel.font = .defaultFont(size: 15, weight: .bold)
            self.myNameLabel.isUserInteractionEnabled = false
            self.myNameLabel.numberOfLines = 1
            self.myNameLabel.text = "Ronaldo Santana"
            self.myNameLabel.textAlignment = .center
            self.myNameLabel.textColor = .OffBlack
            
            view.addSubview(self.myNameLabel)
            self.myNameLabel.translatesAutoresizingMaskIntoConstraints = false
            self.myNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            self.myNameLabel.bottomAnchor.constraint(equalTo: backgroundGradientView.bottomAnchor, constant: -30).isActive = true
            
        }
        
    }
    
    private var socialMediaStackView: UIStackView! {
        
        willSet { self.socialMediaStackView?.removeFromSuperview() }
        
        didSet {
            
            guard (self.socialMediaStackView != nil) else { return }
            
        }
        
    }
    
    
    private var donationOptionsStackView: UIStackView! {
        
        willSet { self.donationOptionsStackView?.removeFromSuperview() }
        
        didSet {
            
            guard (self.donationOptionsStackView != nil) else { return }
            
            self.donationOptionsStackView.alignment = .center
            self.donationOptionsStackView.axis = .horizontal
            self.donationOptionsStackView.distribution = .fillEqually
            self.donationOptionsStackView.spacing = 30
            
            
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.backgroundGradientView = UIView()
        self.ronaldssImageView = UIImageView()
        self.myNameLabel = UILabel()
        self.socialMediaStackView = UIStackView()
        self.donationOptionsStackView = UIStackView()
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        ronaldssImageView?.layer.cornerRadius = ronaldssImageView.frame.width / 2
        
    }

}
