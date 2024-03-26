//
//  FetchWalletDetailsFromCoreData.swift
//  EthereumWallet
//
//  Created by Sharon Varghese on 27/03/2024.
//

import Foundation

class FetchFromCacheUseCase {
    func fetchWalletDetails() -> Wallet.Response? {
        guard let walletDetails = CoreDataManager.shared.fetchWalletDetails() else {
            print("No WalletDetails found")
            return nil
        }

        let nfts = (walletDetails.nfts as? Set<WalletNFT>)?.compactMap { nftEntity -> NFT? in
            var nftDictionary: [String: Any] = [:]
            nftDictionary["contract"] = ["address": nftEntity.contractAddress]
            nftDictionary["id"] = ["tokenId": nftEntity.tokenId]
            nftDictionary["title"] = nftEntity.title
            nftDictionary["description"] = nftEntity.description
            nftDictionary["tokenUri"] = ["gateway": nftEntity.tokenUri]
            nftDictionary["media"] = [["gateway": nftEntity.imageURL]]
            return NFT(dictionary: nftDictionary)
        } ?? []

        return Wallet.Response(
            walletAddress: walletDetails.walletAddress,
            walletBalance: walletDetails.walletBalance,
            transacrtionCount: Int(walletDetails.transactionCount),
            nfts: nfts
        )
    }


}
