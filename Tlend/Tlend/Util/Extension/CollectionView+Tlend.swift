//
//  CollectionView+Tlend.swift
//  Tlend
//
//  Created by 이혜진 on 2018. 11. 13..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import Foundation
import UIKit

protocol CollectionViewCellType {
    static var identifier: String { get }
}

extension UICollectionViewCell: CollectionViewCellType{
    static var identifier: String {
        return String(describing: self.self)
    }
}

extension UICollectionView {
    func register<Cell>(_ reusableCell: Cell.Type) where Cell: UICollectionViewCell {
        let nib = UINib(nibName: reusableCell.identifier, bundle: nil)
        self.register(nib,
                      forCellWithReuseIdentifier: reusableCell.identifier)
    }
    
    func dequeue<Cell: UICollectionViewCell>(_ reusableCell: Cell.Type,
                       for indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: reusableCell.identifier,
                                             for: indexPath) as? Cell else { return UICollectionViewCell() }
        return cell
    }
}

