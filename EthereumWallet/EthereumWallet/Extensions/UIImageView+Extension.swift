//
//  UIImageView+Extension.swift
//  EthereumWallet
//
//  Created by Sharon Varghese on 26/03/2024.
//
import UIKit
extension UIImageView {
    func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            if let error = error {
                print("Error downloading image: \(error.localizedDescription)")
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Invalid response")
                return
            }

            guard let data = data else {
                print("No data received")
                return
            }

            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    self.image = image
                } else {
                    print("Failed to create image from data")
                }
            }
        }

        task.resume()
    }
}

