//
//  NFTTableViewCell.swift
//  EthereumWallet
//
//  Created by Sharon Varghese on 26/03/2024.
//

import UIKit

class NFTTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    struct Presentable: Hashable{
        var nfts: [NFTCollectionViewCell.Presentable]?
    }

    // MARK: @IBOutlets
    @IBOutlet weak var titleLabel: CustomLabel!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: @IBOutlets
    var data: Presentable? {
        didSet {
            collectionView.reloadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        registerCollectionView()
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
        titleLabel.text = "NFTs"
    }
    
    
    func registerCollectionView() {
        collectionView.register(UINib(nibName: "NFTCollectionViewCell", bundle: nil), forCellWithReuseIdentifier:NFTCollectionViewCell.reuseIdentifier)
    }
    
    // MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.nfts?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NFTCollectionViewCell.reuseIdentifier, for: indexPath) as! NFTCollectionViewCell
        let cellData = data?.nfts?[indexPath.row]
        cell.data = cellData
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.contentView.frame.size.width - 48)/4
        let size = CGSize(width: width, height: width)
        return size
    }
    
}
