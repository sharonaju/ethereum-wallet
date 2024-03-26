//
//  SaveWalletDetailsUseCase.swift
//  EthereumWallet
//
//  Created by Sharon Varghese on 27/03/2024.
//

import Foundation
import Foundation

class SaveToCacheUseCase {
    
    func saveWalletDetails(response: Wallet.Response) {
        guard let walletAddress = response.walletAddress,
              let walletBalance = response.walletBalance,
              let transactionCount = response.transacrtionCount else {
            print("Missing required wallet details")
            return
        }

        // Create or update WalletDetails entity
        guard let walletDetails = CoreDataManager.shared.createOrUpdateWalletDetails(walletAddress: walletAddress, walletBalance: walletBalance, transactionCount: transactionCount) else {
            print("Failed to create or update WalletDetails entity")
            return
        }

        // Create WalletNFT entities and associate them with WalletDetails
        response.nfts?.forEach { nft in
            CoreDataManager.shared.createWalletNFT(for: walletDetails, tokenId: nft.tokenId, title: nft.title ?? "", description: nft.description ?? "", tokenUri: nft.tokenUri ?? "")
        }
    }

}
