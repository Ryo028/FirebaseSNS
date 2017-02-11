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

    var targetName:String! = ""
    var targetContent: String! = ""
    var targetHour: String! = ""
    
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
                self.targetName = row.value
            }
            <<< TextAreaRow("Quo") {
                $0.textAreaHeight = .dynamic(initialTextViewHeight: 100)
                $0.placeholder = "名言を入れてください"
            }.onChange{ row in
                self.targetContent = row.value
            }
        
        form +++ Section("コメント")
            <<< TextAreaRow("Comment") {
                $0.textAreaHeight = .dynamic(initialTextViewHeight: 100)
                $0.placeholder = "入力してください"
            }.onChange{ row in
                self.targetContent = row.value
            }
        form +++ Section()
            <<< ButtonRow() {
                $0.title = "プレビュー"
                }.onCellSelection({ (cell, row) in
                    self.performSegue(withIdentifier: "ToPreview", sender: self)
                })
        
        
//        let title: ActionSheetRow? = form.rows(tag: "TitleRow")
//        let titleValue = title?.value
        
        // テキストエリアの値を取得
//        let textRow: TextAreaRow? = form.rowBy(tag: "TextAreaRow")
//        let textValue = textRow?.value
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 投稿処理
    internal func onClick(sender: UIButton) {
        let fireAccess = FireAccess()
        
        let values = form.values()
        
        let name = values["Name"] as! String?
        let quo = values["Quo"] as! String?
        let comment = values["Comment"] as! String?
        let photo = values["Pic"] as! UIImage

        fireAccess.create(name: name, quotation: quo, comment: comment, photo: photo)
        //initImageView()
    }
}
