//
//  MyMediaAlbumCollectionViewCell.swift
//  Euphoria
//
//  Created by Anna Ogorodova on 23.10.2022.
//

import UIKit

class MyMediaAlbumCollectionViewCell: UICollectionViewCell {
    static let identifier = "MyMediaAlbumCollectionViewCell"
    @IBOutlet weak var albumImg: UIImageView!
    @IBOutlet weak var albumTitle: UILabel!
    @IBOutlet weak var creatorName: UILabel!
    
    func configure(with viewModel: MyMediaAlbumViewModel) {
        decorate()
        
        albumTitle.text = viewModel.name
        creatorName.text = viewModel.creatorName
        albumImg.sd_setImage(with: viewModel.imageUrl, completed: nil)
    }
    
    private func decorate() {
        albumImg.layer.masksToBounds = false
        albumImg.layer.cornerRadius = albumImg.frame.size.width/4
        albumImg.clipsToBounds = true
    }
}

