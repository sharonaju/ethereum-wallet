# Ethereum Wallet iOS Application

This project is an Ethereum wallet application for iOS, built using Swift. It follows the Clean Swift architecture and the VIP (View Interactor Presenter) pattern to provide a clean and scalable codebase. The app allows users to display wallet addresses, balances, details, NFTs, and NFT details. Unit test cases are included to ensure code quality and reliability.

## Features

- Display Ethereum wallet address, balance, and details
- Fetch and display NFTs and their details
- Offline data storage using CoreData
- Clean architecture with the Clean Swift template
- Customizable UI components for centralized styling
- Data loading with UITableView and diffable data source
- Unit testing for reliable code

## Folder Structure

- **Data**: Contains CoreData, networking, and repositories
  - **CoreData**: Offline data storage
  - **Networking**: API communication
  - **Repositories**: Data access layer
- **Domain**: Contains Entities and UseCases
  - **Entities**: Data models
  - **UseCases**: Business logic
- **Presentation**: Contains UI and presentation logic
  - **Presenter**: Presentation logic
  - **UIComponents**: Reusable UI components
  - **Extensions**: Helper extensions
  - **Views**: Custom views
  - **ViewController**: View controllers
- **Tests**: Contains unit test cases

## Customization

- **Font**: Custom class for font styles
- **Color**: Custom class for color schemes
- **Label**: Custom class for label styles

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/ethereum-wallet-ios.git
 
2. Open the project in Xcode:
    ```bash
     open ethereum-wallet-ios.xcodeproj
     ```
3. Build and run the application on your iOS device or simulator.

## Running Tests

To run the unit tests, select the test target in Xcode and press Cmd + U.

## Requirements
- iOS 13.0 or later
- Xcode 12.0 or later
- Swift 5.0 or later
