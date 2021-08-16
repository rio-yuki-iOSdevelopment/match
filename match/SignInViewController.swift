//
//  SignInViewController.swift
//  match
//
//  Created by 樋口裕貴 on 2021/08/15.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {
    
    
    @IBOutlet weak var rmailTextField: UITextField!
    @IBOutlet weak var dontHaveAccountButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var LoginButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func tappedLoginButton() {
        guard let email = rmailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        
        Auth.auth().signIn(withEmail: email, password: password) { (res, err) in
            if let err = err {
                print("ログインに失敗しました。\(err)")
                
                return
            }
            
            
            
            print("ログインに成功しました。")
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let rootViewController = storyboard.instantiateViewController(withIdentifier: "RootTabBarController")
            UIApplication.shared.keyWindow?.rootViewController = rootViewController
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
}
