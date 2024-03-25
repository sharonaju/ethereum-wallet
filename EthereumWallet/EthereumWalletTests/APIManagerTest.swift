//
//  APIManagerTest.swift
//  EthereumWalletTests
//
//  Created by Sharon Varghese on 25/03/2024.
//

import XCTest
@testable import EthereumWallet

class APIManagerTests: XCTestCase {

    func testCallAlchemyAPIWithValidRequest() {
        let apiManager = APIManager.shared
        
        let expectation = self.expectation(description: "API call should not fail with a valid request")
        apiManager.callAlchemyAPI(method: "eth_getBalance", params: ["0xd8da6bf26964af9d7eed9e03e53415d37aa96045", "latest"]) { result in
            switch result {
            case .success:
                expectation.fulfill()
            case .failure(let error):
                XCTFail("API call failed with error: \(error)")
            }
        }
        
        waitForExpectations(timeout: 50, handler: nil)
    }



    // Add more test cases as needed
}


