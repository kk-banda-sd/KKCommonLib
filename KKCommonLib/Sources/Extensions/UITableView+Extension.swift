//
//  UITableView+Extension.swift
//  KKCommonLib
//
//  Created by Kostya Karakay on 30.05.2023.
//

import UIKit

public extension UITableView {
    func removeSeparatorsOfEmptyCells() {
        self.tableFooterView = UIView(frame: .zero)
    }
    
    func removeSeparatorsOfEmptyCellsAndLastCell() {
        self.tableFooterView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 0, height: 1)))
    }
}
