//
//  CollectionCellDecoration.swift
//  Euphoria
//
//  Created by Assylzhan Izbassar on 04.10.2022.
//

import UIKit

protocol CollectionCellDecoration {
    func makeRoundedCorners(_ cornerRadius: CGFloat?, _ shadowRadius: CGFloat?, _ offset: CGSize?)
}
