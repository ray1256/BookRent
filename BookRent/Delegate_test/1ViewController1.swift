//
//  1ViewController1.swift
//  BookRent
//
//  Created by 郭瑋 on 2021/9/12.
//

import UIKit

class _ViewController1: UIViewController {

    var delegate:PrintWhatDelegate?
    @IBOutlet weak var textfield: UITextField!
    
    
    
    @IBAction func button_com(_ sender: UIButton) {
        //送出
        self.delegate?.PrintWhat(textfield.text ?? "")
        
        print(textfield.text)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

