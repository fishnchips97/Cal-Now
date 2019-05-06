//
//  MainCalendarEventCell.swift
//  Cal Now
//
//  Created by Mangesh Darke and Erik Fisher on 4/25/19.
//  Copyright © 2019 DarkeFisher. All rights reserved.
//

import Foundation
import UIKit

class MainCalendarEventCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var dateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
