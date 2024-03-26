//
//  CoreDataManager.swift
//  EthereumWallet
//
//  Created by Sharon Varghese on 27/03/2024.
//

import CoreData
import UIKit

class CoreDataManager {
    static let shared = CoreDataManager()

    private init() {}

    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Wallet")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    // MARK: - Core Data Fetching
    func fetchWalletDetails() -> WalletDetails? {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<WalletDetails> = WalletDetails.fetchRequest()

        do {
            let results = try context.fetch(fetchRequest)
            return results.first
        } catch {
            print("Failed to fetch WalletDetails: \(error)")
            return nil
        }
    }

    func createOrUpdateWalletDetails(walletAddress: String, walletBalance: String, transactionCount: Int) -> WalletDetails? {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<WalletDetails> = WalletDetails.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "walletAddress == %@", walletAddress)

        do {
            let results = try context.fetch(fetchRequest)
            let walletDetails = results.first ?? WalletDetails(context: context)
            walletDetails.walletAddress = walletAddress
            walletDetails.walletBalance = walletBalance
            walletDetails.transactionCount = Int32(transactionCount)

            // Clear existing NFTs before adding new ones
            if let existingNFTs = walletDetails.nfts as? Set<WalletNFT> {
                existingNFTs.forEach(context.delete)
            }

            saveContext()
            return walletDetails
        } catch {
            print("Failed to fetch or create WalletDetails: \(error)")
            return nil
        }
    }
    
    func createWalletNFT(for walletDetails: WalletDetails, tokenId: String, title: String, description: String, tokenUri: String) {
            let context = persistentContainer.viewContext
            let walletNFT = WalletNFT(context: context)
            walletNFT.tokenId = tokenId
            walletNFT.title = title
            walletNFT.tokenUri = tokenUri
            walletDetails.addToNfts(walletNFT)
            saveContext()
        }
}
