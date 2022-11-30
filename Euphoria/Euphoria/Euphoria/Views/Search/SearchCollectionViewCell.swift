//
//  SearchCollectionViewCell.swift
//  Euphoria
//
//  Created by macbook on 23.11.2022.
//

import UIKit

class SearchCollectionViewCell: BaseCollectionViewCell {
    
    @IBOutlet weak var title: UILabel!
    
    func configure(with genre: Genre) {
        title.text = genre.name
    }
}
