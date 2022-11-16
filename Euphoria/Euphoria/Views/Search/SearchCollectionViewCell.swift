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
    
    func configure(with genre: Genre) {
        title.text = genre.name
    }
}
