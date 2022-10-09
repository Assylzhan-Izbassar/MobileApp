//
//  PopularCollectionViewCell.swift
//  Euphoria
//
//  Created by Ayana Nygmetova on 09.10.2022.
//

import UIKit

class PopularCollectionViewCell: BaseCollectionViewCell {
    @IBOutlet weak var genreName: UILabel!
    
    func configure(with genre: Category) {
        genreName.text = NSLocalizedString(genre.name, comment: "")
    }
}
