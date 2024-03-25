//
//  String+Extension.swift
//  EthereumWallet
//
//  Created by Sharon Varghese on 25/03/2024.
//

import Foundation
extension String {
    func weiToEther() -> Double? {
        guard let balanceDecimal = UInt64(self.stripHexPrefix(), radix: 16) else {
            return nil
        }
        let ether = Double(balanceDecimal) / pow(10, 18)
        return ether.isFinite ? ether : nil
    }
    
    func stripHexPrefix() -> String {
        return hasPrefix("0x") ? String(dropFirst(2)) : self
    }
}
