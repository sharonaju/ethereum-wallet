//
//  NFT.swift
//  EthereumWallet
//
//  Created by Sharon Varghese on 26/03/2024.
//

struct NFT {
    let contractAddress: String
    let tokenId: String
    let tokenUri: String?
    let metadata: [String: Any]?
    let image: String?
    let name: String?
    let description: String?

    init?(dictionary: [String: Any]) {
        guard let contractAddress = dictionary["contractAddress"] as? String,
              let tokenId = dictionary["tokenId"] as? String else {
            return nil
        }

        self.contractAddress = contractAddress
        self.tokenId = tokenId
        self.tokenUri = dictionary["tokenUri"] as? String
        self.metadata = dictionary["metadata"] as? [String: Any]
        self.image = metadata?["image"] as? String
        self.name = metadata?["name"] as? String
        self.description = metadata?["description"] as? String
    }
}
