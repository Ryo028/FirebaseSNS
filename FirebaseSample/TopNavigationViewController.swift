//
//  TopNavigationViewController.swift
//  FirebaseSample
//
//  Created by Ryo on 2017/03/19.
//  Copyright © 2017年 tamiya. All rights reserved.
//

import UIKit
import ZoomTransitioning

final class TopNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private let zoomNavigationControllerDelegate = ZoomNavigationControllerDelegate()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        delegate = zoomNavigationControllerDelegate
    }
}
