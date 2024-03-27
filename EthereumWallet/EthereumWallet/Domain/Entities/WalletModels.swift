//
//  WalletModels.swift
//  EthereumWallet
//
//  Created by Sharon Varghese on 25/03/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum Wallet
{  
    struct Response
    {
        var walletAddress: String?
        var walletBalance: String?
        var transacrtionCount: Int?
        var nfts: [NFT]?
        
    }
    
    enum ViewControllerSection: Hashable {
        case details
        case NFTs
    }
}
