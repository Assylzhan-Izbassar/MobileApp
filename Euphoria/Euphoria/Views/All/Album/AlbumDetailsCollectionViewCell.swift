//
//  AlbumDetailsCollectionViewCell.swift
//  Euphoria
//
//  Created by Assylzhan Izbassar on 26.10.2022.
//

import UIKit

class AlbumDetailsCollectionViewCell: UICollectionViewCell, GradientBackground {
    static let identifier = "AlbumDetailsCollectionViewCell"
    
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var artistName: UILabel!

    func configure(with viewModel: AlbumDetailsCellViewModel) {
        trackName.text = viewModel.name
        artistName.text = viewModel.artistName
    }
}
