//
//  PostViewController.swift
//  FirebaseSample
//
//  Created by Miyata on 2017/01/30.
//  Copyright © 2017年 tamiya. All rights reserved.
//

import UIKit
import Eureka
import ImageRow

class PostViewController: FormViewController {

    var name:String!
    var quotaion: String!
    var comment: String!
    
    private var myRightButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myRightButton = UIBarButtonItem(title: "投稿", style: .plain, target: self, action: #selector(PostViewController.onClick(sender:)))
        self.navigationItem.rightBarButtonItem = myRightButton
        
        // スペースを生成
//        form +++ Section(){ section in
//            section.header = {
//                var header = HeaderFooterView<UIView>(.callback({
//                    let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
//                    //view.backgroundColor = .red
//                    return view
//                }))
//                header.height = { 0.1 }
//                return header
//            }()
//        }
        form +++ Section()
            <<< ImageRow("Pic") {
                $0.title = "Image"
                $0.sourceTypes = .PhotoLibrary
                $0.clearAction = .no
            }.cellUpdate { cell, row in
                    cell.accessoryView?.layer.cornerRadius = 17
                    cell.accessoryView?.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
                }
            
            <<< TextRow("Name") {
                $0.title = "Name"
                $0.placeholder = "Ryo Miyata"
            }.onChange{ row in
                self.name = row.value
            }
            <<< TextAreaRow("Quo") {
                $0.textAreaHeight = .dynamic(initialTextViewHeight: 100)
                $0.placeholder = "名言を入れてください"
            }.onChange{ row in
                self.quotaion = row.value
            }
        
        form +++ Section("コメント")
            <<< TextAreaRow("Comment") {
                $0.textAreaHeight = .dynamic(initialTextViewHeight: 100)
                $0.placeholder = "入力してください"
            }.onChange{ row in
                self.comment = row.value
            }
        form +++ Section()
            <<< ButtonRow() {
                $0.title = "プレビュー"
                }.onCellSelection({ (cell, row) in
                    self.performSegue(withIdentifier: "ToPreview", sender: self)
                })        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let formValue = form.values()
        if segue.identifier == "ToPreview" {
            let previewController = segue.destination as! PreViewController
            //let previewImg = (formValue["Pic"] as! UIImage)
            previewController.formDataDic = formValue
        }
    }
    
    // 投稿処理
    internal func onClick(sender: UIButton) {
        let fireAccess = FireAccess()
        // ekurakaのformの値を取得
        let formValue = form.values()
        print(String(describing: type(of: formValue)))

        // 投稿するデータをfirebaseに送信
        fireAccess.sentFormData(formValueDic: formValue)
    }
}
