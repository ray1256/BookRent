//
//  TableUIViewControllerTableViewController.swift
//  BookRent
//
//  Created by 郭瑋 on 2021/9/6.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase

class TableUIViewControllerTableViewController: UITableViewController{
                                                
    
    
    
    var imagedata = ["01","02","03"]
    var booknamedata = ["原子習慣","超速學習","深夜食堂"]
    var authordata = ["J","K","Z"]
    var owners = ["acer","asus","apple"]
    var lastdaydata = ["3","5","6"]
    
    
    
    var conBookData:[Book]! = []
    var BookData:[Book]! = []
    var loadingBook:[Book]! = []
    
    
    
    
        
    
    
    
    
    
    
    
    let nib = UINib(nibName: "TableUIView", bundle: nil)
    
    
    
        
    override func viewDidLoad() {
        
        loadingloading()
        
        
        
        
        let ref = Database.database().reference(withPath: "Book")
        ref.queryOrdered(byChild: "booktitle").observe(.value,with: { [self](snapshot) in
        // 使用self.loadingBook = [Book]() 取代 removeAll()就完成了
        self.loadingBook = [Book]()
        for item in snapshot.children{
            let book = Book(snapshot: item as! DataSnapshot)
            loadingBook!.append(book)
            }
            self.tableView.reloadData()
            dismiss(animated: true, completion: nil)
       })
        
        
        
        self.BookData = conBookData
        let loading = LoadingViewController()
        loading.modalPresentationStyle = .overCurrentContext
        loading.modalTransitionStyle = .crossDissolve
        
        
        refreshControl = UIRefreshControl()
        tableView.refreshControl = refreshControl
        refreshControl?.backgroundColor = UIColor.white
        refreshControl?.tintColor = UIColor.gray
        refreshControl?.addTarget(self, action: #selector(fetchResponse), for:  UIControl.Event.valueChanged)
        super.viewDidLoad()
        //tableView.register(UINib(nibName: "TableUIView", bundle: nil), forCellReuseIdentifier: "TTableUIView")
        
        //self.tableView.addSubview(CollectionView)
        
        
        
        
       
        
        
        
        
        
        
        
        tableView.register(nib, forCellReuseIdentifier: "TTTableUIView")
            //tableView.delegate = self
        //tableView.dataSource = self
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
   
    
    
    // MARK: - func fetchResponse
    
    @objc func fetchResponse(){
        
        let ref = Database.database().reference(withPath: "Book")
        ref.queryOrdered(byChild: "booktitle").observe(.value, with: {(snapshot) in
            self.loadingBook = [Book]()
            for item in snapshot.children{
                let book = Book(snapshot: item as! DataSnapshot)
                self.loadingBook.append(book)
            }
        })
        
        
        if let refreshcontrol = self.refreshControl{
            if refreshcontrol.isRefreshing{
                tableView.reloadData()
                refreshControl?.endRefreshing()
            }
        }
    }
    
    
    

    // MARK: - CollectionView
    // 多少Count
    /*
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    // set cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionView", for: indexPath) as! CollectionViewCell
        return cell
    }
    */
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return loadingBook!.count
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TableUIView = tableView.dequeueReusableCell(withIdentifier: "TTTableUIView", for: indexPath) as! TableUIView
        
        //cell.image_1.image = UIImage(named: imagedata[indexPath.row])
        
        
        cell.bookname.text = loadingBook[indexPath.row].booktitle
        cell.author.text = loadingBook[indexPath.row].bookauthors
        cell.owner.text = loadingBook[indexPath.row].booktitle
        cell.count_day.text = String(indexPath.row)
        cell.backgroundColor = .init(red: 201, green: 148, blue: 115, alpha: 0)

        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "BookDetail", sender: nil)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue : UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "BookDetail"{
            let controller = segue.destination as? BookDetailViewController
            
            
            if let row = tableView.indexPathForSelectedRow?.row{
                controller?.BDImage = UIImageView(image: UIImage(named: imagedata[row]))
                controller?.BDImageString = imagedata[row]
                controller?.BDBookName = booknamedata[row]
                controller?.BDAuthor = authordata[row]
                
            }
        }
        
    }
    
}

extension TableUIViewControllerTableViewController{
    func loadingloading(){
        let loadingVC = LoadingViewController()
        loadingVC.modalPresentationStyle = .overCurrentContext
        loadingVC.modalTransitionStyle = .crossDissolve
        self.tabBarController?.present(loadingVC, animated: true, completion: nil)
        
    }
}

