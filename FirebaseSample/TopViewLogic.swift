//
//  TopViewLogic.swift
//  FirebaseSample
//
//  Created by Ryo on 2017/02/26.
//  Copyright © 2017年 tamiya. All rights reserved.
//

import Foundation
import UIKit

public class TopViewLogic {
    
    // テキストフィールドのスタイルを設定
    internal func setQuoTextViewStyle(cell: TopCollectionViewCell) {

        // 文字の影の位置
        cell.quoTextView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        // 影の色
        cell.quoTextView.layer.shadowColor = UIColor.black.cgColor
        cell.quoTextView.layer.shadowOpacity = 1.0
        
        cell.normalImage.layer.cornerRadius = 5
        cell.normalImage.layer.masksToBounds = true
        
//        cell.quoTextView.isEditable = false
//        cell.quoTextView.isScrollEnabled = false
//        let textStyle = NSMutableParagraphStyle()
//        
//        // 行間
//        textStyle.lineSpacing = 5.0
//        
//        // フォントスタイル
//        let fontStyle: String = "ヒラギノ明朝 ProN W6"
//        let fontSize: CGFloat = 13.0
//        let font = UIFont(name: fontStyle, size: fontSize)!
//        cell.quoTextView.textColor = UIColor.white
//        
//        // スタイルをセット
//        let attributes: Dictionary = [NSParagraphStyleAttributeName: textStyle, NSFontAttributeName: font]
//        
//        cell.quoTextView.attributedText = NSAttributedString(string: cell.quoTextView.text, attributes: attributes)

//        return cell.quoTextView.attributedText
    }

}
