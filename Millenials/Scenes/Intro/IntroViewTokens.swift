//
//  IntroViewTokens.swift
//  Millenials
//
//  Created by Ronaldo Santana on 20/07/22.
//  Copyright © 2022 Ronaldo Santana. All rights reserved.
//

import UIKit

struct IntroViewTokens: Decodable, Hashable, Equatable {
    
    static let defaultTokens = IntroViewTokens(logoImageTokens: .init(), mainButtonTokens: .init(), leftButtonTokens: .init(), rightButtonTokens: .init())
    
    var logoImageTokens: LogoImage
    struct LogoImage: Decodable, Hashable, Equatable {
        
        enum CodingKeys: String, CodingKey {
            case image, backgroundColor, tintColor
        }
        
        let image: UIImage
        let backgroundColor: UIColor
        let tintColor: UIColor
        
        init() {
            self.image = UIImage(named: "Millenials_Icon")!
            self.backgroundColor = .clear
            self.tintColor = .OffWhite
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: Self.CodingKeys.self)
            self.image = UIImage(named: try values.decode(String.self, forKey: .image))!
            self.backgroundColor = UIColor(hex: try values.decode(String.self, forKey: .backgroundColor))
            self.tintColor = UIColor(hex: try values.decode(String.self, forKey: .tintColor))
        }
        
        func hash(into hasher: inout Hasher) {
            for property in [image as AnyHashable, backgroundColor as AnyHashable, tintColor as AnyHashable] { hasher.combine(property) }
        }
        
        static func == (lhs: Self, rhs: Self) -> Bool {
            return lhs.image == rhs.image &&
            lhs.backgroundColor == rhs.backgroundColor &&
            lhs.tintColor == rhs.tintColor
        }
        
    }
    
    var mainButtonTokens: MainButton
    struct MainButton: Decodable, Hashable, Equatable {
        
        enum CodingKeys: String, CodingKey {
            case cornerRadius, backgroundColor, titleColor, font, title
        }
        
        let cornerRadius: CGFloat
        let backgroundColor: UIColor
        let titleColor: UIColor
        let font: UIFont
        let title: String
        
        init() {
            self.cornerRadius = 8.0
            self.backgroundColor = .OffWhite.withAlphaComponent(0.96)
            self.titleColor = .LightPurple
            self.font = .defaultFont(size: (isiPad ? 26 : 22), weight: .medium)
            self.title = localized("PlayGame")
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: Self.CodingKeys.self)
            self.cornerRadius = try values.decode(CGFloat.self, forKey: .cornerRadius)
            self.backgroundColor = UIColor(hex: try values.decode(String.self, forKey: .backgroundColor))
            self.titleColor = UIColor(hex: try values.decode(String.self, forKey: .titleColor))
            self.font = .defaultFont(size: 26, weight: .medium)
            self.title = try values.decode(String.self, forKey: .title)
        }
        
        func hash(into hasher: inout Hasher) {
            for property in [backgroundColor as AnyHashable, titleColor as AnyHashable, font as AnyHashable, title as AnyHashable] { hasher.combine(property) }
        }
        
        static func == (lhs: Self, rhs: Self) -> Bool {
            return lhs.cornerRadius == rhs.cornerRadius &&
            lhs.backgroundColor == rhs.backgroundColor &&
            lhs.titleColor == rhs.titleColor &&
            lhs.font == rhs.font &&
            lhs.title == rhs.title
        }
        
    }
    
    var leftButtonTokens: LeftButton
    struct LeftButton: Decodable, Hashable, Equatable {
        
        enum CodingKeys: String, CodingKey {
            case backgroundColor, image, imageTintColor
            case title, titleColor, titleFont
        }
        
        let backgroundColor: UIColor
        let image: UIImage
        let imageTintColor: UIColor
        let title: String
        let titleColor: UIColor
        let titleFont: UIFont
        
        init() {
            self.backgroundColor = .OffWhite.withAlphaComponent(0.96)
            if #available(iOS 13.0, macCatalyst 13.0, *) {
                self.image = UIImage(systemName: "questionmark", withConfiguration: UIImage.SymbolConfiguration(scale: .large))!
            } else {
                self.image = UIImage()
            }
            self.imageTintColor = .LightPurple
            self.title = "?"
            self.titleColor = .LightPurple
            self.titleFont = .defaultFont(size: (isiPad ? 35 : 25), weight: .medium)
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: Self.CodingKeys.self)
            self.backgroundColor = UIColor(hex: try values.decode(String.self, forKey: .backgroundColor))
            if #available(iOS 13.0, macCatalyst 13.0, *) {
                self.image = UIImage(systemName: try values.decode(String.self, forKey: .image), withConfiguration: UIImage.SymbolConfiguration(scale: .large))!
            } else {
                self.image = UIImage()
            }
            self.imageTintColor = UIColor(hex: try values.decode(String.self, forKey: .imageTintColor))
            self.title = try values.decode(String.self, forKey: .title)
            self.titleColor = UIColor(hex: try values.decode(String.self, forKey: .titleColor))
            self.titleFont = .defaultFont(size: (isiPad ? 35: 25), weight: .medium)
        }
        
        func hash(into hasher: inout Hasher) {
            for property in [backgroundColor as AnyHashable, image as AnyHashable, imageTintColor as AnyHashable, title as AnyHashable, titleColor as AnyHashable, titleFont as AnyHashable] { hasher.combine(property) }
        }
        
        static func == (lhs: Self, rhs: Self) -> Bool {
            return lhs.backgroundColor == rhs.backgroundColor &&
            lhs.image == rhs.image &&
            lhs.imageTintColor == rhs.imageTintColor &&
            lhs.title == rhs.title &&
            lhs.titleColor == rhs.titleColor &&
            lhs.titleFont == rhs.titleFont
        }
        
    }
    
    var rightButtonTokens: RightButton
    struct RightButton: Decodable, Hashable, Equatable {
        
        enum CodingKeys: String, CodingKey {
            case backgroundColor, imageTintColor
        }
        
        let soundOn: UIImage = {
            if #available(iOS 13.0, macCatalyst 13.0, *) {
                return UIImage(systemName: "speaker.3", withConfiguration: UIImage.SymbolConfiguration(scale: .large))!
            } else {
                return UIImage(named: "SpeakerDefault")!.withRenderingMode(.alwaysTemplate)
            }
        }()

        let soundOff: UIImage = {
            if #available(iOS 13.0, macCatalyst 13.0, *) {
                return UIImage(systemName: "speaker.slash", withConfiguration: UIImage.SymbolConfiguration(scale: .large))!
            } else {
                return UIImage(named: "SpeakerMute")!.withRenderingMode(.alwaysTemplate)
            }
        }()
        
        let backgroundColor: UIColor
        let imageTintColor: UIColor
        
        init() {
            self.backgroundColor = .OffWhite.withAlphaComponent(0.96)
            self.imageTintColor = .LightPurple
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: Self.CodingKeys.self)
            self.backgroundColor = UIColor(hex: try values.decode(String.self, forKey: .backgroundColor))
            self.imageTintColor = UIColor(hex: try values.decode(String.self, forKey: .imageTintColor))
        }
        
        func hash(into hasher: inout Hasher) {
            for property in [soundOn as AnyHashable, soundOff as AnyHashable, backgroundColor as AnyHashable, imageTintColor as AnyHashable] { hasher.combine(property) }
        }
        
        static func == (lhs: Self, rhs: Self) -> Bool {
            return lhs.backgroundColor == rhs.backgroundColor &&
            lhs.imageTintColor == rhs.imageTintColor
        }
        
    }
    
    func hash(into hasher: inout Hasher) {
        for property in [logoImageTokens as AnyHashable, mainButtonTokens as AnyHashable, leftButtonTokens as AnyHashable, rightButtonTokens as AnyHashable] { hasher.combine(property) }
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.logoImageTokens == rhs.logoImageTokens &&
        lhs.mainButtonTokens == rhs.mainButtonTokens &&
        lhs.leftButtonTokens == rhs.leftButtonTokens &&
        lhs.rightButtonTokens == rhs.rightButtonTokens
    }
    
}
