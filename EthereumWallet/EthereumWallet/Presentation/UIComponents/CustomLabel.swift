//
//  CustomLabel.swift
//  EthereumWallet
//
//  Created by Sharon Varghese on 26/03/2024.
//

import UIKit
enum LabelStyle {
    case textPrimaryBold18
    case textPrimaryRegular18
}

class CustomLabel: UILabel {
    var style: LabelStyle? {
        didSet {
            setLabelStyle()
        }
    }
    
    func setLabelStyle() {
        switch style {
        case .textPrimaryBold18:
            self.textColor = CustomColor.textPrimary.instance
            self.font = CustomFont(fontName: .bold, size: 18).instance
        case .textPrimaryRegular18:
            self.textColor = CustomColor.textPrimary.instance
            self.font = CustomFont(fontName: .regular, size: 18).instance
        default:
            break
        }
    }
}
