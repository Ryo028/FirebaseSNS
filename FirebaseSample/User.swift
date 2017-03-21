//
//  User.swift
//  FirebaseSample
//
//  Created by Ryo on 2017/03/21.
//  Copyright © 2017年 tamiya. All rights reserved.
//

import Foundation

class User: Salada.Object {
    // 型に別名を付ける
    typealias Element = User
    
    dynamic var name: String?
    dynamic var thumURL: String?
}
