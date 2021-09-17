//
//  TableUIView.swift
//  BookRent
//
//  Created by 郭瑋 on 2021/9/6.
//

import UIKit

class TableUIView: UITableViewCell,NibOwnerLoadable,UICollectionViewDelegate,UICollectionViewDataSource{
    
    
    @IBOutlet weak var CollectionView_1: UICollectionView!
    @IBOutlet weak var bookname: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var owner: UILabel!
    @IBOutlet weak var count_day: UILabel!
    
    var count = ["01","02","03"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        CollectionView_1.register(UINib(nibName: "PhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCell")
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        layout.minimumLineSpacing = 5
        //layout.scrollDirection = .horizontal
        layout.itemSize.height = self.frame.height
        layout.itemSize.width = UIScreen.main.bounds.width - 30
        CollectionView_1.collectionViewLayout = layout
        CollectionView_1.delegate = self
        CollectionView_1.dataSource = self
        // Initialization code
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return count.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionViewcell = CollectionView_1.dequeueReusableCell(withReuseIdentifier:"PhotoCell", for: indexPath) as! PhotoCollectionViewCell
        
        collectionViewcell.boook_image.image = UIImage(named: count[indexPath.row])
                
        return collectionViewcell
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
