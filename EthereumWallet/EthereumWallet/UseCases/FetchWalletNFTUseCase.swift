//
//  FetchWalletNFT.swift
//  EthereumWallet
//
//  Created by Sharon Varghese on 26/03/2024.
//

import Foundation

import Foundation

class FetchWalletNFTsUseCase {
    
    var walletAddress = ""
    var apiManager = APIManager()
    
    init(walletAddress: String = "", apiManager: APIManager) {
        self.walletAddress = walletAddress
        self.apiManager = apiManager
    }
    
    func fetch(completion: @escaping (Result<[NFT], Error>) -> Void) {
        let params: [Any] = [["owner": walletAddress]]
        apiManager.callAlchemyAPI(method: "alchemy_getNFTs", params: params) { result in
            switch result {
            case .success(let response):
                let parseResult: Result<[NFT], Error> = self.apiManager.parseResponse(response, parseFunction: self.parseNFTs)
                switch parseResult {
                case .success(let nfts):
                    completion(.success(nfts))
                case .failure(let error):
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    
    private func parseNFTs(_ response: Any) -> [NFT]? {
        guard let responseDict = response as? [String: Any],
              let nftsArray = responseDict["ownedNfts"] as? [[String: Any]] else {
            return nil
        }
        return nftsArray.compactMap { NFT(dictionary: $0) }
    }
}
