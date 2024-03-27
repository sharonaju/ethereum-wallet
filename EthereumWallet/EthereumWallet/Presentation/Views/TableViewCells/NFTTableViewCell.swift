//
//  NFTTableViewCell.swift
//  EthereumWallet
//
//  Created by Sharon Varghese on 27/03/2024.
//

import UIKit

class NFTTableViewCell: UITableViewCell {
    
    struct Presentable: Hashable{
        var nftImageURLString: String?
        var title: String?
        var tokenId: String?
        
    }

    // MARK: @IBOutlets
    @IBOutlet weak var titleLabel: CustomLabel!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var nftImageView: UIImageView!
    
    // MARK: @IBOutlets
    var data: Presentable? {
        didSet {
            loadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI() {
        
        bgView.backgroundColor = CustomColor.backgroundCard.instance
        bgView.layer.cornerRadius = 12.0
        titleLabel.style = .textPrimaryBold18
        nftImageView.layer.cornerRadius = 4
        nftImageView.backgroundColor = CustomColor.backgroundBlack.instance
    }
    
    func loadData() {
        titleLabel.text = data?.title
        if let imageUrlString = data?.nftImageURLString,
           let encodedUrlString = imageUrlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed){
            nftImageView.loadImage(from: encodedUrlString)
        } else {
            print("Invalid URL")
        }
    }
    
}
