//
//  FetchTransactionCountUseCaseTest.swift
//  EthereumWalletTests
//
//  Created by Sharon Varghese on 26/03/2024.
//

import XCTest
@testable import EthereumWallet

class FetchWalletTransactionsCountUseCaseTests: XCTestCase {

    var fetchWalletTransactionsCountUseCase: FetchWalletTransactionsCountUseCase!
    var mockAPIManager: MockAPIManager!

    override func setUp() {
        super.setUp()
        mockAPIManager = MockAPIManager()
        fetchWalletTransactionsCountUseCase = FetchWalletTransactionsCountUseCase(walletAddress: "0xd8da6bf26964af9d7eed9e03e53415d37aa96045", apiManager: mockAPIManager)
    }

    override func tearDown() {
        fetchWalletTransactionsCountUseCase = nil
        mockAPIManager = nil
        super.tearDown()
    }

    func testFetchTransactionCount_Success() {
        let expectedCount = 1224
        mockAPIManager.mockResponse = ["jsonrpc": "2.0", "id": 1, "result": "0x4c8"]

        let expectation = XCTestExpectation(description: "Fetch transaction count")

        fetchWalletTransactionsCountUseCase.fetch { result in
            switch result {
            case .success(let count):
                XCTAssertEqual(count, expectedCount)
            case .failure:
                XCTFail("Expected successful transaction count fetch")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 30.0)
    }

    func testFetchTransactionCount_Failure() {
        mockAPIManager.mockResponse = nil

        let expectation = XCTestExpectation(description: "Fetch transaction count failure")

        fetchWalletTransactionsCountUseCase.fetch { result in
            switch result {
            case .success:
                XCTFail("Expected failure in transaction count fetch")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 30.0)
    }
}

