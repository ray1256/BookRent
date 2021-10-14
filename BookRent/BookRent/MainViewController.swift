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

class MainViewController: UIViewController {

    @IBOutlet weak var account: MainView!
    @IBOutlet weak var password: MainView!
    
    var ref:DatabaseReference!
    var book:[Book]?
    
    
    
    
    func getInfo(){
        
        ref = Database.database().reference().child("Book")
        ref.queryOrdered(byChild: "booktitle").observe(.value, with: {(snapshot) in
               var OnlineItem = [Book]()
            for Item in snapshot.children{
                let book = Book(snapshot: Item as! DataSnapshot)
                OnlineItem.append(book)
            }
            self.book = OnlineItem
            
    })
    }
    
    
    

    @IBAction func login(_ sender: Any) {
        Auth.auth().signIn(withEmail: account.textfield.text!, password: password.textfield.text!, completion: {
            (user,error) in
            if error != nil{
                let ErrorAlert = UIAlertController(title: "Error Alert", message: "Alert", preferredStyle: .alert)
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
        /*@IBAction func FBLogin(_ sender: Any) {
        
       let FBLogin = FBSDKCoreKit()
        FBLogin.log
        
    }
    */
    
    @IBAction func GoogleLogin(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        Auth.auth().addStateDidChangeListener{(auth,user) in
            if user != nil {
                self.performSegue(withIdentifier: "LogIning", sender: nil)
            }
        }
        getInfo()
        
        
    }
    
    
    
  
    
    // MARK: - Navigation


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LogIning"{
            let destination = segue.destination as? TableUIViewControllerTableViewController
            //destination?.conBookData = book
            
            
        }
    }
    

}
