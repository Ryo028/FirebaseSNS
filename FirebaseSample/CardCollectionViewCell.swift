//
//  CardCollectionViewCell.swift
//  FirebaseSample
//
//  Created by Miyata on 2017/01/22.
//  Copyright © 2017年 tamiya. All rights reserved.
//

import UIKit
import Material

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cardLable: UILabel!
    @IBOutlet weak var cardView: Card!
    @IBOutlet weak var cardImage: ImageCard!
    @IBOutlet weak var normalImage: UIImageView!
    @IBOutlet weak var quoTextView: UITextView!
    @IBOutlet weak var cardBottomBar: Bar!
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userMsgLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!

    }
}
