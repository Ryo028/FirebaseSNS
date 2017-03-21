//
//  QuoData.swift
//  FirebaseSample
//
//  Created by Ryo on 2017/03/21.
//  Copyright © 2017年 tamiya. All rights reserved.
//

import Foundation

class QuoData: Salada.Object {
    
    typealias Element = QuoData
    
    dynamic var name: String?
    dynamic var quotaion: String?
    dynamic var imageURL: URL?
    dynamic var image: Salada.File?
    dynamic var comment: String?

}
