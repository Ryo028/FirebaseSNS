//
//  logic.swift
//  FirebaseSample
//
//  Created by Miyata on 2017/01/22.
//  Copyright © 2017年 tamiya. All rights reserved.
//

import Foundation
import UIKit

class Login: UIViewController {
    
    public func moveViewController() {
        self.performSegue(withIdentifier: "ToLanking", sender: self)
    }
    

}
