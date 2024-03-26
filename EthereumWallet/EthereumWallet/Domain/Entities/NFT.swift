//
//  NFT.swift
//  EthereumWallet
//
//  Created by Sharon Varghese on 26/03/2024.
//

struct NFT {
    let contractAddress: String
    let tokenId: String
    let title: String?
    let description: String?
    let tokenUri: String?
    let imageUrl: String?
    let metadata: [String: Any]?

    init?(dictionary: [String: Any]) {
        guard let contract = dictionary["contract"] as? [String: Any],
              let contractAddress = contract["address"] as? String,
              let id = dictionary["id"] as? [String: Any],
              let tokenId = id["tokenId"] as? String else {
            return nil
        }

        self.contractAddress = contractAddress
        self.tokenId = tokenId
        self.title = dictionary["title"] as? String
        self.description = dictionary["description"] as? String
        self.tokenUri = (dictionary["tokenUri"] as? [String: Any])?["gateway"] as? String
        self.imageUrl = (dictionary["media"] as? [[String: Any]])?.first?["gateway"] as? String
        self.metadata = dictionary["metadata"] as? [String: Any]
    }
}





