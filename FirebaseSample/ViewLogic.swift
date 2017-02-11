//
//  ViewLogin.swift
//  FirebaseSample
//
//  Created by Miyata on 2017/01/29.
//  Copyright © 2017年 tamiya. All rights reserved.
//

import Foundation
import UIKit

class ViewLogic: ProfileViewController {
    
    public func test() -> String {
        let test = "テスと"
        return test
    }
    
    
    public func navigationBarAndStatusBarHidden(hidden: Bool, animated: Bool, navCon: UINavigationController) {
        
        if let nv: UINavigationController = navCon {
            
            if nv.isNavigationBarHidden == hidden {
                return
            }
            
            let application = UIApplication.shared
            
            if (hidden) {
                // 隠す
                nv.setNavigationBarHidden(hidden, animated: animated)
                application.setStatusBarHidden(hidden, with: animated ? .slide : .none)
            } else {
                // 表示する
                application.setStatusBarHidden(hidden, with: animated ? .slide : .none)
                nv.setNavigationBarHidden(hidden, animated: animated)
            }
        }
    }

}
