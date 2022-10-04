//
//  BaseCollectionViewCell.swift
//  Euphoria
//
//  Created by Assylzhan Izbassar on 04.10.2022.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell, CollectionCellDecoration {
    
    func makeRoundedCorners(_ cornerRadius: CGFloat?, _ shadowRadius: CGFloat?, _ offset: CGSize?) {
        
        // corner radius
        self.contentView.layer.cornerRadius = cornerRadius ?? 30.0
        self.contentView.layer.borderWidth = 0.0
        self.contentView.layer.masksToBounds = true

        // shadow
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = offset ?? CGSize(width: 5, height: 10)
        self.layer.shadowOpacity = 0.25
        self.layer.shadowRadius = shadowRadius ?? 10.0
        self.layer.masksToBounds = false
        
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
}
