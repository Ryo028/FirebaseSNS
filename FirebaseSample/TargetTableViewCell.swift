//
//  TargetTableViewCell.swift
//  FirebaseSample
//
//  Created by Miyata on 2017/01/28.
//  Copyright © 2017年 tamiya. All rights reserved.
//

import UIKit
import Material

class TargetTableViewCell: UITableViewCell {
    
    @IBOutlet weak var targetView: Card!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
