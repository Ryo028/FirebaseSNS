//
//  TargetContentView.swift
//  FirebaseSample
//
//  Created by Miyata on 2017/01/28.
//  Copyright © 2017年 tamiya. All rights reserved.
//

import UIKit
import Eureka

class TargetContentView: FormViewController {

    let targetList = ["", ""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // スペースを生成
        form +++ Section(){ section in
            section.header = {
                var header = HeaderFooterView<UIView>(.callback({
                    let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
                    return view
                }))
                header.height = { 50 }
                return header
            }()
        }
        
        form +++ Section("目標設定")
            <<< TextRow() {
                $0.title = "タイトル"
                //$0.placeholder = ""
                }.onChange{ row in
                    let userDefault = UserDefaults.standard
                    userDefault.setValue(row.value, forKey: "title")
                }

            <<< DateRow() {
                $0.title = "完了日"
            }
        
        form +++ Section()
            <<< ButtonRow() {
                $0.title = "成果を追加"
            }
            <<< TextAreaRow() {
                $0.textAreaHeight = .dynamic(initialTextViewHeight: 300)
            }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
//    override func viewWillAppear(_ animated: Bool) {
//        let navLogic = ViewLogic()
//        // ナビゲーションバーを再表示
//        navLogic.navigationBarAndStatusBarHidden(hidden: false, animated: true, navCon: navigationController!)
//    }
    
}
