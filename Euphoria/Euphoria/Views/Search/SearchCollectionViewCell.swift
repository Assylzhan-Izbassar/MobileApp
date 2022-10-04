//
//  SearchCollectionViewCell.swift
//  Euphoria
//
//  Created by Assylzhan Izbassar on 04.10.2022.
//

import UIKit

class SearchCollectionViewCell: BaseCollectionViewCell {
    
    @IBOutlet weak var title: UILabel!
    
    func configure(with genre: Genre) {
        title.text = genre.name
    }
}
