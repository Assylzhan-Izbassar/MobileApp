//
//  AlbumHeaderCollectionReusableView.swift
//  Euphoria
//
//  Created by macbook on 28.11.2022.
//

import UIKit

protocol AlbumHeaderCollectionReusableViewDelegate: AnyObject {
    func albumHeaderCollectionReusableViewDelegateDidTapPlayAll(_ header: AlbumHeaderCollectionReusableView)
}

class AlbumHeaderCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "AlbumHeaderCollectionReusableView"
    weak var delegate: AlbumHeaderCollectionReusableViewDelegate?
    
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var albumTitle: UILabel!
    @IBOutlet weak var releasedDate: UILabel!
    @IBOutlet weak var artistName: UILabel!
    
    func configure(with viewModel: AlbumHeaderViewModel) {
        albumTitle.text = viewModel.title
        releasedDate.text = "Release date: \(viewModel.releasedDate ?? "")"
        artistName.text = viewModel.artistName
        headerImage.sd_setImage(with: viewModel.imageUrl, completed: nil)
    }
    @IBAction func playBtnPressed(_ sender: UIButton) {
        delegate?.albumHeaderCollectionReusableViewDelegateDidTapPlayAll(self)
    }
}
