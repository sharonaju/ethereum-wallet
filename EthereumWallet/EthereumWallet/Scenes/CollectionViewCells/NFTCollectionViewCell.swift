//
//  NFTCollectionViewCell.swift
//  EthereumWallet
//
//  Created by Sharon Varghese on 26/03/2024.
//

import UIKit

class NFTCollectionViewCell: UICollectionViewCell {
    
    // MARK: Presentable
    struct Presentable: Hashable{
        var imageURL: String?
        var title: String?
    }
    
    // MARK: @IBOutlets
    @IBOutlet weak var titleLabel: CustomLabel!
    @IBOutlet weak var nftImageView: UIImageView!
    
    // MARK: Properties
    var data: Presentable? {
        didSet {
            loadData()
        }
    }
    
    static let reuseIdentifier = "CheckoutProductCollectionViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    func setupUI() {
        nftImageView.layer.cornerRadius = 4
        titleLabel.style = .textPrimaryRegular18
    }
    
    func loadData() {
        titleLabel.text = data?.title
        nftImageView.loadImage(from: data?.imageURL ?? "")
    }

}
