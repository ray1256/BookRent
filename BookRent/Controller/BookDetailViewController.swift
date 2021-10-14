//
//  BookDetailViewController.swift
//  BookRent
//
//  Created by 郭瑋 on 2021/9/14.
//

import UIKit

class BookDetailViewController:UITableViewController{//,UICollectionViewDelegate,UICollectionViewDataSource{
    /*func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    */
    
    
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
    var BDBookName: String?
    var BDISBN:String?
    var BDAuthor:String?
    var BDownerimage:UIImageView?
    var BDCompleIntro:String?
    var BDLastDay:String?
    
    
    
   /* override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
 */
    
    func changeto(){
        //Bookimage = BDImage
        
        BookDetailAuthor.text = BDAuthor
        BookDetailBookName.text = BDBookName
    }
    
   /*override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    
        return cell
    }
   
 */
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
        //BookDetailCollectionview.delegate = self
        //BookDetailCollectionview.dataSource = self
        
        
        
        
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
