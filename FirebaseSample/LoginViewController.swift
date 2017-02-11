//
//  LoginViewController.swift
//  FirebaseSample
//
//  Created by Miyata on 2017/01/15.
//  Copyright © 2017年 tamiya. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        passwordTextField.isSecureTextEntry = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // ログインボタン
    @IBAction func didRegisterUser(_ sender: UIButton) {
        login()
    }
    
    // Returnキーが押されたらキーボードを隠す
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // ランキング画面に遷移
    public func transitionToView() {
        self.performSegue(withIdentifier: "ToLanking", sender: self)
    }
    
    // login処理
    private func login() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if error == nil {
                self.transitionToView()
            } else {
                print("\(error?.localizedDescription)")
            }
            
        })
    }
    
}
