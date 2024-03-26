//
//  FetchWalletNFTUseCaseTest.swift
//  EthereumWalletTests
//
//  Created by Sharon Varghese on 26/03/2024.
//

import XCTest
@testable import EthereumWallet
class FetchWalletNFTsUseCaseTests: XCTestCase {

    var fetchWalletNFTsUseCase: FetchWalletNFTsUseCase!
    var mockAPIManager: MockAPIManager!

    override func setUp() {
        super.setUp()
        mockAPIManager = MockAPIManager()
        fetchWalletNFTsUseCase = FetchWalletNFTsUseCase(walletAddress: "0xd8da6bf26964af9d7eed9e03e53415d37aa96045", apiManager: mockAPIManager)
    }

    override func tearDown() {
        fetchWalletNFTsUseCase = nil
        mockAPIManager = nil
        super.tearDown()
    }

    func testFetchNFTs_Success() {
        let expectedNFTs = [
            NFT(dictionary: [
                "contractAddress": "0xabc",
                "tokenId": "1",
                "tokenUri": nil as String? ?? "",
                "metadata": nil as [String: Any]? ?? ["":""]
            ])
        ].compactMap { $0 }

        mockAPIManager.mockResponse = ["ownedNfts": [["contractAddress": "0xabc", "tokenId": "1"]]]

        let expectation = XCTestExpectation(description: "Fetch NFTs")

        fetchWalletNFTsUseCase.fetch { result in
            switch result {
            case .success(let nfts):
                XCTAssertEqual(nfts.count, expectedNFTs.count)
                XCTAssertEqual(nfts[0].contractAddress, expectedNFTs[0].contractAddress)
                XCTAssertEqual(nfts[0].tokenId, expectedNFTs[0].tokenId)
            case .failure:
                XCTFail("Expected successful NFT fetch")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func testFetchNFTs_Failure() {
        mockAPIManager.mockError = APIManager.APIError.invalidResponse

        let expectation = XCTestExpectation(description: "Fetch NFTs failure")

        fetchWalletNFTsUseCase.fetch { result in
            switch result {
            case .success:
                XCTFail("Expected failure in NFT fetch")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }
}
