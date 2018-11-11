//
//  TableView+Tlend.swift
//  CandyPlanner
//
//  Created by KanghoonOh on 2018. 11. 11..
//  Copyright © 2018년 kanghoon. All rights reserved.
//

import UIKit

protocol TableViewCellType {
    static var identifier: String { get }
}

extension UITableViewCell: TableViewCellType{
    static var identifier: String {
        return String(describing: self.self)
    }
}

extension UITableView {
    func register<Cell>(_ reusableCell: Cell.Type) where Cell: UITableViewCell {
        let nib = UINib(nibName: reusableCell.identifier, bundle: nil)
        self.register(nib,
                      forCellReuseIdentifier: reusableCell.identifier)
    }
    
    func dequeue<Cell>(_ reusableCell: Cell.Type,
                       for indexPath: IndexPath) -> Cell where Cell: UITableViewCell{
        return dequeueReusableCell(withIdentifier: reusableCell.identifier,
                                   for: indexPath) as! Cell
    }
}
