//
//  CollectionViewCell.swift
//  BookRent
//
//  Created by 郭瑋 on 2021/9/10.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var cate: UILabel!
    
    @IBOutlet weak var catemark: UIImageView!
    override func awakeFromNib() {
        
        let layout = UICollectionViewFlowLayout()
        // Section間的間距
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        // cell間距
        layout.minimumLineSpacing = 5
        // cell長寬
        layout.itemSize = CGSize(width:100,height: 30)
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 10, width: 414, height: 50),collectionViewLayout: layout)
        collectionView.backgroundColor = .gray
        
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        
        var delegate:TableUIViewControllerTableViewController?
        
        //collectionView.delegate = delegate
        //collectionView.dataSource = delegate
        
        
        super.awakeFromNib()
        // Initialization code
    }

}
