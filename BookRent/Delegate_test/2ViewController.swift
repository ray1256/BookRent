//
//  2ViewController.swift
//  BookRent
//
//  Created by 郭瑋 on 2021/9/12.
//

import UIKit

class _ViewController: UIViewController {

   
    @IBOutlet weak var Label_1: UILabel!
    var VC2:_ViewController1?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        VC2?.delegate = self
        
        

        // Do any additional setup after loading the view.
    }
  
}
extension _ViewController: PrintWhatDelegate{
    func PrintWhat(_ txt: String) {
        Label_1.text = "shit\(txt)"
        print("jit\(txt)")
    }
}
