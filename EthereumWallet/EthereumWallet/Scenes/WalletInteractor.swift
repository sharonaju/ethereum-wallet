//
//  WalletInteractor.swift
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

protocol WalletBusinessLogic
{
    func fetchWalletDetails(address: String)
}

protocol WalletDataStore
{
  //var name: String { get set }
}

class WalletInteractor: WalletBusinessLogic, WalletDataStore
{
    var presenter: WalletPresentationLogic?
    let apiManager = APIManager.shared
    
    
    func fetchWalletDetails(address: String) {
        var viewModel = Wallet.Response()
        viewModel.walletAddress = address
        let group = DispatchGroup()
        
        group.enter()
        let balanceUseCase = FetchWalletBalanceUseCase(walletAddress: address, apiManager: apiManager)
        balanceUseCase.fetch { result in
            switch result {
            case .success(let balance):
                viewModel.walletBalance = balance
            case .failure(let failure):
                print("Fetch balance failed:: \(failure.localizedDescription)")
            }
            group.leave()
        }
        
        group.enter()
        let transactionsCountUseCase = FetchWalletTransactionsCountUseCase(walletAddress: address, apiManager: apiManager)
        transactionsCountUseCase.fetch { result in
            switch result {
            case .success(let count):
                viewModel.transacrtionCount = count
            case .failure(let failure):
                print("Fetch transaction count failed:: \(failure.localizedDescription)")
            }
            group.leave()
        }
        
        group.enter()
        let nftUseCase = FetchWalletNFTsUseCase(walletAddress: address, apiManager: apiManager)
        nftUseCase.fetch { result in
            switch result {
            case .success(let nfts):
                viewModel.nfts = nfts
            case .failure(let failure):
                print("Fetch NFTs  failed:: \(failure.localizedDescription)")
            }
            group.leave()
        }
        
        group.notify(queue: .main) { [weak self] in
            self?.presenter?.presentWalletDetails(response: viewModel)
        }
        
    }
    
    
    
    
    
}
