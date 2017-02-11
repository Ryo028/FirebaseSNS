//
//  SecondViewController.swift
//  FirebaseSample
//
//  Created by Miyata on 2017/01/15.
//  Copyright © 2017年 tamiya. All rights reserved.
//

import UIKit
import Firebase

class SecondViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    let ref = FIRDatabase.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        textField.delegate = self
        //textView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 投稿ボタン
    @IBAction func post(_ sender: UIButton) {
        create()
    }

    // キーボードを隠す
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // データの送信メソッド
    func create() {
        guard let title = textField.text else { return }
        guard let text = textView.text else { return }
        
        let userID = (FIRAuth.auth()?.currentUser?.uid)!
        print("ユーザーID : \(userID)")
        
        self.ref.child(userID).childByAutoId().setValue([
            "userID"  : userID,
            "title"   : title,
            "content" : text,
            "date"    : FIRServerValue.timestamp()
        ])
        
    }
    
    func logout() {
        do {
            //do-try-catchの中で、FIRAuth.auth()?.signOut()を呼ぶだけで、ログアウトが完了
            try FIRAuth.auth()?.signOut()
            //先頭のNavigationControllerに遷移
            //let storyboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Nav")
            //self.present(storyboard, animated: true, completion: nil)
            self.performSegue(withIdentifier: "Nav", sender: self)

        } catch let error as NSError {
            print("\(error.localizedDescription)")
        }
    }
    @IBAction func logoutBtn(_ sender: UIButton) {
        logout()
    }

}

