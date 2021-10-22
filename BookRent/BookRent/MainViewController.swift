//
//  MainViewController.swift
//  BookRent
//
//  Created by 郭瑋 on 2021/9/4.
//

import UIKit
import FirebaseAuth
import FBSDKLoginKit
import Firebase
import GoogleSignIn

class MainViewController: UIViewController, LoginButtonDelegate {
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if let error = error {
            print(error.localizedDescription)
            return
          }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        return
    }
    

    @IBOutlet weak var account: MainView!
    @IBOutlet weak var password: MainView!{
        didSet{
            password.textfield.isSecureTextEntry = true
        }
    }
    
    
    

    @IBAction func login(_ sender: Any) {
        Auth.auth().signIn(withEmail: account.textfield.text!, password: password.textfield.text!, completion: {
            (user,error) in
            if error != nil{
                let ErrorAlert = UIAlertController(title: "Error Alert", message: "InCorrect", preferredStyle: .alert)
                let ErrorAction = UIAlertAction(title: "Error", style: .cancel, handler: nil)
                
                ErrorAlert.addAction(ErrorAction)
                self.present(ErrorAlert, animated: true, completion: nil)
            }
            
            if user != nil{
                self.performSegue(withIdentifier: "LogIning", sender: nil)
            }
        })
        
    }
    
    @IBAction func Register(_ sender: Any) {
        let RegisterAlert = UIAlertController(title: "註冊", message: "請註冊", preferredStyle: .alert)
        let RegisterAction = UIAlertAction(title: "Register Right Now", style: .default){ (action) in
            let emailtextfield = RegisterAlert.textFields![0]
            let passwprdtextfield = RegisterAlert.textFields![1]
            
            Auth.auth().createUser(withEmail: emailtextfield.text!, password: passwprdtextfield.text!,completion:{ (user,error) in
                if error == nil{
                    Auth.auth().signIn(withEmail: emailtextfield.text!, password: passwprdtextfield.text!, completion: nil)
                }else{
                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alert.addAction(alertAction)
                    self.present(alert, animated: true, completion: nil)
                }              })
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        
        RegisterAlert.addTextField{(emailtextfield) in emailtextfield.placeholder = "請輸入Email"}
        RegisterAlert.addTextField{(passwordtextfield) in passwordtextfield.placeholder = "請輸入password"
            passwordtextfield.isSecureTextEntry = true
        }
        
        RegisterAlert.addAction(RegisterAction)
        RegisterAlert.addAction(cancelAction)
        
        present(RegisterAlert, animated: true, completion: nil)
        
        
        
    }
    @IBAction func FBLogin(_ sender: Any) {
        
    }
    
    
    
    
    @IBAction func GoogleLogin(_ sender: Any) {
    }
    
    // MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        let loginButton = FBLoginButton()
        loginButton.delegate = self
        loginButton.frame.origin = CGPoint(x: 99, y: 686)
        loginButton.frame.size = CGSize(width:203,height:36)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        loginButton.layer.cornerRadius = 5
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        self.view.addGestureRecognizer(tap) // to Replace "TouchesBegan"
        view.addSubview(loginButton)
    }
    
    @objc func dismissKeyBoard(){
        self.view.endEditing(true)
    }
    //MARK: - 忘記密碼
    
    @IBAction func ForgetPassword(_ sender: Any) {
        
        let AlertController = UIAlertController(title: "請輸入Email", message:"", preferredStyle: .alert)
        let Action = UIAlertAction(title: "OK", style: .default, handler: {(error) in
           
            let email = AlertController.textFields![0]
            Auth.auth().sendPasswordReset(withEmail: email.text!, completion: {(error) in

                if error != nil{
                    let alcontroller = UIAlertController(title: "Error", message: "Incorrect Email", preferredStyle: .alert)
                    let alaction = UIAlertAction(title: "ok", style: .default, handler: nil)
                    alcontroller.addAction(alaction)
                    self.present(alcontroller, animated: true, completion: nil)
                    print("Error",error?.localizedDescription)
                }else{
                    let alcontroller = UIAlertController(title: "Send Success", message: "Receive Your Email", preferredStyle: .alert)
                    let alaction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alcontroller.addAction(alaction)
                    self.present(alcontroller, animated: true, completion: nil)
                }
            })
        })
        
        
        //告訴這個裡面有一個TextField要去呈現
        AlertController.addTextField{email in email}
        
        
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        AlertController.addAction(cancel)
        AlertController.addAction(Action)
        present(AlertController, animated: true, completion: nil)
        }

    
  
    
    // MARK: - Navigation


    
    


}
