//
//  FetchWalletBalanceUseCaseTest.swift
//  EthereumWalletTests
//
//  Created by Sharon Varghese on 26/03/2024.
//

import XCTest
@testable import EthereumWallet

class FetchWalletBalanceUseCaseTests: XCTestCase {

    var fetchWalletBalanceUseCase: FetchWalletBalanceUseCase!
    var mockAPIManager: MockAPIManager!

    override func setUp() {
        super.setUp()
        mockAPIManager = MockAPIManager()
        fetchWalletBalanceUseCase = FetchWalletBalanceUseCase(walletAddress: "0xd8da6bf26964af9d7eed9e03e53415d37aa96045", apiManager: mockAPIManager)
    }

    override func tearDown() {
        fetchWalletBalanceUseCase = nil
        mockAPIManager = nil
        super.tearDown()
    }

    func testFetchWalletBalance_Success() {
        let expectedBalance = "705.272"
        mockAPIManager.mockResponse = ["jsonrpc": "2.0", "id": 1, "result": "0x263b9d3d8ad33cc405"]

        let expectation = XCTestExpectation(description: "Fetch wallet balance")

        fetchWalletBalanceUseCase.fetch { result in
            switch result {
            case .success(let balance):
                XCTAssertEqual(balance, expectedBalance)
            case .failure:
                XCTFail("Expected successful wallet balance fetch")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 20.0)
    }

    func testFetchWalletBalance_Failure() {
        mockAPIManager.mockResponse = nil

        let expectation = XCTestExpectation(description: "Fetch wallet balance failure")

        fetchWalletBalanceUseCase.fetch { result in
            switch result {
            case .success:
                XCTFail("Expected failure in wallet balance fetch")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 20.0)
    }
}
