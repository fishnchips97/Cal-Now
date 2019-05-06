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
    
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
