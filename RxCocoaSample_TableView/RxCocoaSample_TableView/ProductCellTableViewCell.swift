//
//  ProductCellTableViewCell.swift
//  RxCocoaSample_TableView
//
//  Created by yangjs on 2022/08/05.
//

import UIKit

class ProductCellTableViewCell: UITableViewCell {
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    override func prepareForReuse() {
        
        super.prepareForReuse()
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
}
