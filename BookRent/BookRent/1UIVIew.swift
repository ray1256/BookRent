//
//  1UIVIew.swift
//  BookRent
//
//  Created by 郭瑋 on 2021/9/12.
//

import UIKit

class _UIVIew: UIView {
    
    
    var delegate:printWhatDelegate?
    @IBAction func texyfield(_ sender: Any) {
    }
    @IBAction func button(_ sender: Any) {
        self.delegate?.PrintWhat(texyfield.text)
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
protocol printWhatDelegate {
    func PrintWhat(_ txt:String)
}


