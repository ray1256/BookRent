//
//  MainView.swift
//  BookRent
//
//  Created by 郭瑋 on 2021/9/4.
//

import UIKit

@IBDesignable
class MainView: UIView,NibOwnerLoadable {
    
    
    // Can see property
    
    // 輸入的txt
    @IBInspectable var txt : String = ""{
        didSet{
            textfield.text = txt
        }
    }
    
    //PlaceHolder是右側的輸入
    @IBInspectable var placeHolder: String = ""{
        didSet{
            textfield.placeholder = placeHolder
        }
    }

   
    
    
   
    @IBOutlet weak var textfield: UITextField!
    
    
    
    
    // 讓這些東西可以在IB上顯示
    override func prepareForInterfaceBuilder() {
            super.prepareForInterfaceBuilder()
            textfield.text = txt
            textfield.placeholder = placeHolder
        }
    
    
    override init(frame:CGRect){
        super.init(frame: frame)
        custominit()
        
    }
    
    required init?(coder:NSCoder){
        super.init(coder: coder)
        custominit()
        
    }
    
    private func custominit(){
        loadNibContent()
    }
    
    
    // 初始化
    override func awakeFromNib() {
        super.awakeFromNib()
        textfield.text = txt
        textfield.placeholder = placeHolder
        
    }
    
    
    
    
    
    

}


