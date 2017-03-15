//
//  ProfileViewController.swift
//  FirebaseSample
//
//  Created by Miyata on 2017/01/28.
//  Copyright © 2017年 tamiya. All rights reserved.
//

import Foundation
import UIKit
import Material

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var targetTableView: UITableView!
    
    let texts = ["Monday", "Tuesday", "Wednesday"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        let nav = ViewLogic()
//        // ナビゲーションバーを非表示にする
//        nav.navigationBarAndStatusBarHidden(hidden: true, animated: true, navCon: navigationController!)
        //UIApplication.shared.isStatusBarHidden = true
    }
    
    /// セルの個数を指定するデリゲートメソッド（必須）
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return texts.count
    }
    
    /// セルに値を設定するデータソースメソッド（必須）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // セルの取得
        let cell: TargetTableViewCell = tableView.dequeueReusableCell(withIdentifier: "TargetCell") as! TargetTableViewCell
        // セルに表示する値を設定する
        //cell.myLabel2.text = texts[indexPath.row]
        
        return cell
    }
    
    /// セルが選択された時に呼ばれるデリゲートメソッド
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ToTargetContent", sender: nil)
    }
        

}
