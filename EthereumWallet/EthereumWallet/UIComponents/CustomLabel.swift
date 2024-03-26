//
//  CustomLabel.swift
//  EthereumWallet
//
//  Created by Sharon Varghese on 26/03/2024.
//

import UIKit
enum LabelStyle {
    case textPrimaryBold12
    case textPrimaryRegular12
}

class CustomLabel: UILabel {
    var style: LabelStyle? {
        didSet {
            
        }
    }
    
    func setLabelStyle() {
        switch style {
        case .textPrimaryBold12:
            self.textColor = CustomColor.textPrimary.instance
            self.font = CustomFont(fontName: .bold, size: 12).instance
        case .textPrimaryRegular12:
            self.textColor = CustomColor.textPrimary.instance
            self.font = CustomFont(fontName: .regular, size: 12).instance
        default:
            break
        }
    }
}
