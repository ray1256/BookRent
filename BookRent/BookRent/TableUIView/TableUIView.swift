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
    
    var imageData:[Data]? = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        CollectionView_1.register(UINib(nibName: "PhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCell")
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        layout.minimumLineSpacing = 5
        //layout.scrollDirection = .horizontal
        layout.itemSize.height = self.frame.height
        layout.itemSize.width = UIScreen.main.bounds.width
        CollectionView_1.collectionViewLayout = layout
        CollectionView_1.delegate = self
        CollectionView_1.dataSource = self
        // Initialization code
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageData?.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionViewcell = CollectionView_1.dequeueReusableCell(withReuseIdentifier:"PhotoCell", for: indexPath) as! PhotoCollectionViewCell
        if imageData != nil{
        
        collectionViewcell.boook_image.image = UIImage(data: (imageData?[indexPath.row])!)
        }else{
            
            print("imageData == nil",imageData)
            collectionViewcell.boook_image.image = UIImage(named: "03")
        }
                
        return collectionViewcell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
    }
    
    func update(imageData:[String]){
        var imageStorage = [Data]()
        
        do{
        for i in imageData{
            let imageURL = URL(string: i)
            let imageinData = try Data(contentsOf: imageURL!)
            imageStorage.append(imageinData)
        }
        }catch{
            print("Error",error)
        }
        self.imageData = imageStorage
        
    }
    
   
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
