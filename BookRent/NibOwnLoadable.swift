//
//  NibOwnLoadable.swift
//  BookRent
//
//  Created by 郭瑋 on 2021/9/5.
//

import UIKit

// 編寫一個符合協議的人都能讀取nib內容的方法

protocol NibOwnerLoadable: AnyObject{
    static var nib:UINib { get}
}


// Default implementation
extension NibOwnerLoadable{
    static var nib:UINib{
        UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }
}


// Supporting method
extension NibOwnerLoadable where Self: UIView{
    
    func loadNibContent(){
        guard let views = Self.nib.instantiate(withOwner:self,options: nil) as? [UIView],let contentView = views.first else{
            fatalError("Fail to load \(self) nib content")
        }

        self.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
    }
}


