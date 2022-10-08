//
//  SearchCollectionViewCell.swift
//  Euphoria
//
//  Created by Assylzhan Izbassar on 04.10.2022.
//

import UIKit

class SearchCollectionViewCell: BaseCollectionViewCell, GradientBackground {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
    
    func configure(with genre: Genre, _ image: UIImage) {
        title.text = genre.name
        cellImage.layer.frame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height)
        cellImage.image = image
    }
}
