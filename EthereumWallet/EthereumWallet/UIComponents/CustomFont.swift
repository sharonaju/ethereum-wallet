//
//  CustomFont.swift
//  EthereumWallet
//
//  Created by Sharon Varghese on 26/03/2024.
//

import UIKit

struct CustomFont {
    
    enum AppFontName: String {
        case bold = "HelveticaNeue-Bold"
        case medium = "HelveticaNeue-Medium"
        case regular = "HelveticaNeue"
    }
    enum FontName: String {
        case bold
        case medium
        case regular
        
        var name: String {
            switch self {
            case .bold: return AppFontName.bold.rawValue
            case .medium: return AppFontName.medium.rawValue
            case .regular: return AppFontName.regular.rawValue
            }
        }
        
    }
    
    var fontName: FontName
    var size: CGFloat
    
    var instance: UIFont {
        guard let font = UIFont(name: fontName.name, size: size) else {
            fatalError("\(fontName.name) is not installed, make sure it is added")
        }
        return font
    }
    
    init(fontName: FontName, size: CGFloat) {
        self.fontName = fontName
        self.size = size
    }
}


