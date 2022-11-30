//
//  FavoriteCollectionViewCell.swift
//  Euphoria
//
//  Created by macbook on 14.11.2022.
//

import UIKit

class FavoriteCollectionViewCell: BaseCollectionViewCell{
    
    @IBOutlet weak var albumName: UILabel!
    
    func configure(with playlist: MyMediaPlaylistViewModel) {
        albumName.text = playlist.name
    }
}
