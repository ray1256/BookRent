//
//  TableUIView.swift
//  BookRent
//
//  Created by 郭瑋 on 2021/9/6.
//

import UIKit

class TableUIView: UITableViewCell,NibOwnerLoadable{

    
    
    
    @IBOutlet weak var image_1: UIImageView!
    @IBOutlet weak var bookname: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var owner: UILabel!
    @IBOutlet weak var count_day: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
   
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
