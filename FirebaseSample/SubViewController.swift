//
//  SubViewController.swift
//  FirebaseSample
//
//  Created by Ryo on 2017/03/12.
//  Copyright © 2017年 tamiya. All rights reserved.
//

import UIKit

class SubViewController: UIViewController {

    @IBOutlet weak var subImageView: UIImageView!
    @IBOutlet weak var subTextView: UITextView!
    @IBOutlet weak var subLable: UILabel!
    
    public var contentDic: [String: Any]! = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        subImageView.image = contentDic["Image"] as? UIImage
        subTextView.text = contentDic["Quotation"] as? String
        subLable.text = contentDic["Name"] as? String
        print(contentDic)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
