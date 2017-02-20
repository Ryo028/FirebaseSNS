//
//  FireAccess.swift
//  FirebaseSample
//
//  Created by Miyata on 2017/02/03.
//  Copyright © 2017年 tamiya. All rights reserved.
//

import Foundation
import Firebase

public class FireAccess {
    
    let ref: FIRDatabaseReference
    let storage: FIRStorage
    let storageRef: FIRStorageReference
    var imgTimestamp: String!
    
//    var name: String
//    var quotation: String
//    var comment: String
    
    init() {
        self.ref = FIRDatabase.database().reference()
        self.storage = FIRStorage.storage()
        self.storageRef = self.storage.reference(forURL: "gs://fir-sample-1e7e7.appspot.com")
//        self.name = ""
//        self.quotation = ""
//        self.comment = ""
    }
    
    // データの送信メソッド
    public func sentFormData(formValueDic: [String: Any?]) -> Void {
        
//        guard let name = name else { return }
//        guard let quotation = quotation else { return }
//        guard let comment = comment else { return }
        //guard let photo = photo else { return }
        
        print(formValueDic)
        
        let name = formValueDic["Name"] as! String
        let quotation = formValueDic["Quo"] as! String
        let comment = formValueDic["Comment"] as! String
        let photo = formValueDic["Pic"] as! UIImage
        
        let userID = (FIRAuth.auth()?.currentUser?.uid)!
        let personNo = arc4random_uniform(99999999) + 10000000
        
        let newPohto = drawText(image: photo, quoText: quotation)
        
        self.ref.child(userID).childByAutoId().setValue([
            "UserID"    : userID,
            "Name"      : name,
            "Quotation" : quotation,
            "Commnet"   : comment,
            "Date"      : FIRServerValue.timestamp(),
            "PersonImg" : personNo.description + ".jpg"
            ])
        
        // 偉人の画像をアップロード
        if let data = UIImagePNGRepresentation(newPohto) {
            let imageRef = storageRef.child("images/" + userID + "/" + personNo.description + ".jpg")
            imageRef.put(data, metadata: nil, completion: { metaData, error in
//                if error = nil {
//                
//                }
//                print(metaData)
//                print(error)
            })
        }

    }
    
    // 画像に名言と名前を埋め込む処理
    private func drawText(image: UIImage, quoText: String) -> UIImage {
        
        // 文字の太さを指定
        let font = UIFont.boldSystemFont(ofSize: 32)
        // 描画領域を生成
        let imageRect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        
        // 画像をPDFに変換
        UIGraphicsBeginImageContext(image.size)
        
        image.draw(in: imageRect)
        
        let quoRect = CGRect(x: 10, y: 10, width: image.size.width - 10, height: image.size.height - 10)
        let textStyle = NSMutableParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        let textFontAttributes = [
            NSFontAttributeName: font,
            NSForegroundColorAttributeName: UIColor.white,
            NSParagraphStyleAttributeName: textStyle
        ]
        quoText.draw(in: quoRect, withAttributes: textFontAttributes)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}
