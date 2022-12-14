//
//  PopularCollectionViewCell.swift
//  Euphoria
//
//  Created by Амира Байжулдинова on 14.11.2022.
//

import UIKit

class PopularCollectionViewCell: BaseCollectionViewCell {
    @IBOutlet weak var genreName: UILabel!
    
    func configure(with genre: Category) {
        genreName.text = NSLocalizedString(genre.name, comment: "")
    }
}
