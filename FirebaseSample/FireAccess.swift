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
    
    init() {
        self.ref = FIRDatabase.database().reference()
        self.storage = FIRStorage.storage()
        self.storageRef = self.storage.reference(forURL: "gs://fir-sample-1e7e7.appspot.com")
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
        
        //let newPhoto = drawText(image: photo, quoText: quotation)
        let newPhoto = cropThumbnailImage(image: photo, w: 343, h: 458, quoText: quotation, quoName: name)
        
        self.ref.child(userID).childByAutoId().setValue([
            "UserID"    : userID,
            "Name"      : name,
            "Quotation" : quotation,
            "Commnet"   : comment,
            "Date"      : FIRServerValue.timestamp(),
            "PersonImg" : personNo.description + ".png"
            ])
        
        // 偉人の画像をアップロード
        if let data = UIImagePNGRepresentation(newPhoto) {
            let imageRef = storageRef.child("images/" + userID + "/" + personNo.description + ".png")
            imageRef.put(data, metadata: nil, completion: { metaData, error in
//                if error = nil {
//                
//                }
//                print(metaData)
//                print(error)
            })
        }

    }
    
    // リサイズ処理
    private func cropThumbnailImage(image: UIImage, w: Int, h: Int, quoText: String, quoName: String) -> UIImage {
        let origRef    = image.cgImage
        let origWidth  = Int(origRef!.width)
        let origHeight = Int(origRef!.height)
        var resizeWidth:Int = 0
        var resizeHeight:Int = 0
        
        if (origWidth < origHeight) {
            resizeWidth = w
            resizeHeight = origHeight * resizeWidth / origWidth
        } else {
            resizeHeight = h
            resizeWidth = origWidth * resizeHeight / origHeight
        }
        
        let resizeSize = CGSize.init(width: CGFloat(resizeWidth), height: CGFloat(resizeHeight))
        // 画像の処理を開始
        UIGraphicsBeginImageContext(resizeSize)
        
        // 名言を描画
        // 文字の太さを指定
        let font = UIFont.boldSystemFont(ofSize: 32)
        let quoRect = CGRect(x: CGFloat(resizeWidth / 2), y: CGFloat(resizeHeight / 2), width: image.size.width, height: image.size.height)
        let textStyle = NSMutableParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        let textFontAttributes = [
            NSFontAttributeName: font,
            NSForegroundColorAttributeName: UIColor.white,
            NSParagraphStyleAttributeName: textStyle
        ]
        quoText.draw(in: quoRect, withAttributes: textFontAttributes)

        //リサイズ
        image.draw(in: CGRect.init(x: 0, y: 0, width: CGFloat(resizeWidth), height: CGFloat(resizeHeight)))
        
        // リサイズ後の画像を取得
        let resizeImage = UIGraphicsGetImageFromCurrentImageContext()
        // 画像処理を終了
        UIGraphicsEndImageContext()
        
        // 切り抜き処理
        let cropRect  = CGRect.init(x: CGFloat((resizeWidth - w) / 2), y: CGFloat((resizeHeight - h) / 2), width: CGFloat(w), height: CGFloat(h))
        let cropRef   = resizeImage!.cgImage!.cropping(to: cropRect)
        let cropImage = UIImage(cgImage: cropRef!)
        
        return cropImage
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
        
        let quoRect = CGRect(x: 50, y: 50, width: image.size.width, height: image.size.height)
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


