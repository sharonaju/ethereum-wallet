//
//  WalletPresenter.swift
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

protocol WalletPresentationLogic
{
    func presentWalletDetails(response: Wallet.Response)
}

class WalletPresenter: WalletPresentationLogic
{
  weak var viewController: WalletDisplayLogic?
  
    func presentWalletDetails(response: Wallet.Response) {
        var snapShot = NSDiffableDataSourceSnapshot<Wallet.ViewControllerSection, AnyHashable>()
        snapShot.appendSections([.details])
        let addressModel = DetailsTableViewCell.Presentable(title: "Wallet Address", description: response.walletAddress)
        let balanceModel = DetailsTableViewCell.Presentable(title: "Balance", description: response.walletBalance)
        let transactions = "\(response.transacrtionCount ?? 0)"
        let transactionsCount = DetailsTableViewCell.Presentable(title: "Total Transactions", description: transactions)
        snapShot.appendItems([addressModel, balanceModel, transactionsCount])
        let title = TitleTableViewCell.Presentable(title: "NFTs")
        snapShot.appendItems([title])
        if let nfts = response.nfts {
            for item in nfts {
                let imageURL = item.metadata?["image"] as? String
                let model = NFTTableViewCell.Presentable(nftImageURLString: imageURL, title: item.title, tokenId: item.tokenId)
                snapShot.appendItems([model])
            }
        }
        viewController?.displayWalletDetails(snapShot)
    }
 
}
