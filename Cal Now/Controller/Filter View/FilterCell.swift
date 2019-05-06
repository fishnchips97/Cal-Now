//
//  FilterCell.swift
//  Cal Now
//
//  Created by Mangesh Darke and Erik Fisher on 4/25/19.
//  Copyright © 2019 DarkeFisher. All rights reserved.
//

import Foundation
import UIKit

class FilterCell: UITableViewCell {
    
    @IBOutlet weak var filterCategory: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
