//
//  NewReleaseCollectionViewCell.swift
//  Euphoria
//
//  Created by macbook on 26.11.2022.
//

import UIKit
import SDWebImage

class NewReleaseCollectionViewCell: UICollectionViewCell {
    static let identifier = "NewReleaseCollectionViewCell"
    @IBOutlet weak var albumTitle: UILabel!
    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var tracksCount: UILabel!
    
    func configure(with viewModel: NewReleasesCellViewModel) {
        albumTitle.text = viewModel.name
        artistName.text = viewModel.artistName
        tracksCount.text = "Tracks: \(viewModel.numberOfTracks)"
        albumImage.sd_setImage(with: viewModel.artWorkUrl, completed: nil)
    }
}
