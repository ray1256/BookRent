//
//  SearchTableViewCell.swift
//  BookRent
//
//  Created by 郭瑋 on 2021/9/23.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var searchbookimage: UIImageView!
    
    @IBOutlet weak var searchbooktitle: UILabel!
    @IBOutlet weak var searchauthors: UILabel!
    @IBOutlet weak var searchbookisbn: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
