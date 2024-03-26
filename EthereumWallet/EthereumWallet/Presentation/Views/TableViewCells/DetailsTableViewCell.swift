//
//  DetailsTableViewCell.swift
//  EthereumWallet
//
//  Created by Sharon Varghese on 26/03/2024.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {
    
    // MARK: Presentable
    struct Presentable: Hashable {
        var title: String?
        var description: String?
    }
    
    // MARK: @IBOutlets
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var titleLabel: CustomLabel!
    @IBOutlet weak var valueLabel: CustomLabel!
    
    // MARK: Properties
    var data: Presentable? {
        didSet {
            loadData()
        }
    }
   static let reuseIdentifier = "DetailsTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadData() {
        titleLabel.text = data?.title
        valueLabel.text = data?.description
    }
    
    func setupUI() {
        bgView.backgroundColor = CustomColor.backgroundCard.instance
        bgView.layer.cornerRadius = 12.0
        titleLabel.style = .textPrimaryBold18
        valueLabel.style = .textPrimaryRegular18
    }
    
}
