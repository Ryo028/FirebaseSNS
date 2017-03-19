//
//  SubViewController.swift
//  FirebaseSample
//
//  Created by Ryo on 2017/03/12.
//  Copyright © 2017年 tamiya. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorageUI
import ZoomTransitioning

class SubViewController: UIViewController {

    @IBOutlet weak var subImageView: UIImageView!
    @IBOutlet weak var subTextView: UITextView!
    @IBOutlet weak var subLable: UILabel!
    
    public var contentDic: [String: Any]! = [:]
    
    let storageRef = FIRStorage.storage().reference(forURL: "gs://fir-sample-1e7e7.appspot.com")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        subTextView.text = contentDic["Quotation"] as? String
        subLable.text = contentDic["Name"] as? String
        
        print(contentDic)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension SubViewController: ZoomTransitionDestinationDelegate {
    
    func transitionDestinationImageViewFrame(forward: Bool) -> CGRect {
        if forward {
//            let x: CGFloat = 0.0
//            let y = topLayoutGuide.length
//            let width = view.frame.width
//            let height = width * 2.0 / 3.0
//            return CGRect(x: x, y: y, width: width, height: height)
            return subImageView.convert(subImageView.bounds, to: view)
        } else {
            return subImageView.convert(subImageView.bounds, to: view)
        }
    }
    
    func transitionDestinationWillBegin() {
        subImageView.isHidden = true
    }
    
    func transitionDestinationDidEnd(transitioningImageView imageView: UIImageView) {
        subImageView.isHidden = false
        subImageView.image = imageView.image
    }
    
    func transitionDestinationDidCancel() {
        subImageView.isHidden = false
    }
}

