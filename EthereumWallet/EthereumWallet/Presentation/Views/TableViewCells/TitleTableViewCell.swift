//
//  TitleTableViewCell.swift
//  EthereumWallet
//
//  Created by Sharon Varghese on 27/03/2024.
//

import UIKit

class TitleTableViewCell: UITableViewCell {
    
    struct Presentable: Hashable{
        var title: String?
    }

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var titleLabel: CustomLabel!
    
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
        titleLabel.style = .textPrimaryBold18
        bgView.backgroundColor = .clear
    }
    
    func loadData() {
        titleLabel.text = data?.title
    }
    
}
