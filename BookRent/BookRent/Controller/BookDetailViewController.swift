//
//  BookDetailViewController.swift
//  BookRent
//
//  Created by 郭瑋 on 2021/9/14.
//

import UIKit

class BookDetailViewController:UITableViewController,UICollectionViewDelegate,UICollectionViewDataSource{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return BDImageData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionviewReuse = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewReuse", for: indexPath) as! DetailCollectionViewCell
        
        collectionviewReuse.DetailCollectionviewImage.image = UIImage(data: (BDImageData[indexPath.row]))
        
        return collectionviewReuse
    }
    
    
    
    @IBOutlet weak var Bookimage: UIImageView!
    
    @IBOutlet weak var BookDetailCollectionview: UICollectionView!
    @IBOutlet weak var BookDetailBookName: UILabel!
    @IBOutlet weak var BookDetailBookISBN: UILabel!
    @IBOutlet weak var BookDetailAuthor: UILabel!
    @IBOutlet weak var BookDetailIntro: UILabel!
    @IBOutlet weak var BookDetailownerimage: UIImageView!
    @IBOutlet weak var BookDetailCompleIntro: UILabel!
    @IBOutlet weak var BookDetailLastday: UILabel!
    
    var BDImage:UIImageView?
    var BDImageString:[String]?
    var BDImageData:[Data] = []
    var BDBookName: String?
    var BDISBN:String?
    var BDAuthor:String?
    var BDownerimage:UIImageView?
    var BDCompleIntro:String?
    var BDLastDay:String?
    
    
    
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    switch section{
    case 0:
        return 1
    case 1:
        return 3
        
    default:
        return 1
    }
    
    return 1
        
   }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
 
    
    func changeto(){
        //Bookimage = BDImage
        
        BookDetailAuthor.text = BDAuthor
        BookDetailBookName.text = BDBookName
        convert()
    }
    
    func convert(){
        var BDimageArr = [Data]()
        for i in BDImageString!{
            do {
            let BDImageString = URL(string: i)
            let BDImageData = try Data(contentsOf: BDImageString!)
            BDimageArr.append(BDImageData)
            }catch{
                print("ERROR Convert",error)
            }
        }
        
        self.BDImageData = BDimageArr
    }
    
   
   

    override func viewDidLoad() {
        super.viewDidLoad()
        
        changeto()
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        layout.minimumLineSpacing = 5
        layout.scrollDirection = .horizontal
        layout.itemSize.width = view.frame.width
        layout.itemSize.height = 305
        
        BookDetailCollectionview.collectionViewLayout = layout
        BookDetailCollectionview.delegate = self
        BookDetailCollectionview.dataSource = self
        
        
        
        
        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
