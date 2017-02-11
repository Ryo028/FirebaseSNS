//
//  SingupViewController.swift
//  FirebaseSample
//
//  Created by Miyata on 2017/01/15.
//  Copyright © 2017年 tamiya. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class SignupViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self // デリゲートをセット
        passwordTextField.delegate = self
        passwordTextField.isSecureTextEntry = true // 文字を非表示
        
        //self.layoutFacebookButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // ログインしていれば遷移
        if self.checkUserVerify() {
            
            let tabController = self.storyboard!.instantiateViewController(withIdentifier: "TabController")
            tabController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            
            //tabController = tabView!.instantiateViewController(withIdentifier: "ToLanking") as! FirstViewController
            
            self.present(tabController, animated: false, completion: nil)
            
        }
        
    }
    
    // ログイン済みかどうかと、メールのバリデーションが完了しているかを確認
    func checkUserVerify() -> Bool {
        guard let user = FIRAuth.auth()?.currentUser else { return false }
        return true
        //return user.isEmailVerified
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // サインアップボタン
    @IBAction func willSignup(_ sender: UIButton) {
        signup()
    }
    
    // ログイン画面への遷移ボタン
    @IBAction func willTransitionToLogin(_ sender: UIButton) {
        self.transitionToLogin()
    }
    
    // ログイン画面への遷移
    func transitionToLogin() {
        self.performSegue(withIdentifier: "ToLogin", sender: self)
    }
    
    //  リターンキーを押すとキーを隠す
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // サインアップ処理
    private func signup() {
        // email, passwordの文字がなければreturn
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            if error == nil {
                self.transitionToLogin()
            } else {
                print("\(error?.localizedDescription)")
            }

        })
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}
