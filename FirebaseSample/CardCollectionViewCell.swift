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
    @IBOutlet weak var bottomBar: Bar!
    @IBOutlet weak var cardImage: ImageCard!
    @IBOutlet weak var normalImage: UIImageView!
    @IBOutlet weak var quoTextView: UITextView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!

    }
    
    public func setTextViewStyle() {
        self.quoTextView.isEditable = false
        self.quoTextView.isScrollEnabled = false
        let textStyle = NSMutableParagraphStyle()
        textStyle.lineSpacing = 10.0
        
        // スタイルをセット
        let attributes: Dictionary = [NSParagraphStyleAttributeName: textStyle]
        self.quoTextView.attributedText = NSAttributedString(string: quoTextView.text, attributes: attributes)
    }
    
}
