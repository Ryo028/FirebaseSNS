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
    var imgTimestamp: String
    
//    var name: String
//    var quotation: String
//    var comment: String
    
    init() {
        self.ref = FIRDatabase.database().reference()
        self.storage = FIRStorage.storage()
        self.storageRef = self.storage.reference(forURL: "gs://fir-sample-1e7e7.appspot.com")
        self.imgTimestamp = ""
//        self.name = ""
//        self.quotation = ""
//        self.comment = ""
    }
    
    // データの送信メソッド
    func create(name: String?, quotation: String?, comment: String?, photo: UIImage?) {
        
        guard let name = name else { return }
        guard let quotation = quotation else { return }
        guard let comment = comment else { return }
        //guard let photo = photo else { return }
        
        let userID = (FIRAuth.auth()?.currentUser?.uid)!
        let personImg = arc4random_uniform(99999999) + 10000000
        
        self.ref.child(userID).childByAutoId().setValue([
            "UserID"    : userID,
            "Name"      : name,
            "Quotation" : quotation,
            "Commnet"   : comment,
            "Date"      : FIRServerValue.timestamp(),
            "PersonImg" : personImg.description + ".jpg"
            ])
        
        // 偉人の画像をアップロード
        if let data = UIImagePNGRepresentation(photo!) {
            let imageRef = storageRef.child("images/" + userID + "/" + personImg.description + ".jpg")
            imageRef.put(data, metadata: nil, completion: { metaData, error in
//                if error = nil {
//                
//                }
//                print(metaData)
//                print(error)
            })
        }

    }

}
