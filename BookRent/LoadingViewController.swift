//
//  LoadingViewController.swift
//  BookRent
//
//  Created by 郭瑋 on 2021/10/1.
//

import UIKit
import Lottie
import Firebase
import FirebaseStorage


class LoadingViewController: UIViewController{

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let animationView = AnimationView(name: "73734-logo-anmation")
        animationView.frame = CGRect(x: 0, y: 0 ,width: 300, height: 200)
        animationView.center = view.center
        animationView.loopMode = .loop
        animationView.animationSpeed  = 1
        self.view.addSubview(animationView)
        animationView.play()
        view.backgroundColor = UIColor.init(white: 5, alpha: 0.6)
        
        // Do any additional setup after loading the view.
    }
    
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
