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
import Alamofire

class TableUIViewControllerTableViewController: UITableViewController{
                                                
    
    
    
    var imagedata = ["01","02","03"]
    var booknamedata = ["原子習慣","超速學習","深夜食堂"]
    var authordata = ["J","K","Z"]
    var owners = ["acer","asus","apple"]
    var lastdaydata = ["3","5","6"]
    
    let ref:DatabaseReference = Database.database().reference(withPath: "Book")
    
    
    public var loadingBook:[Book]! = []
    var loadBook = [Book]()
    
    
    
        
    
    
    
    
    
    
    
    let nib = UINib(nibName: "TableUIView", bundle: nil)
    
    let fetch = NetworkController1()
    
        
    override func viewDidLoad() {
        
        loadingloading()
        
        
        DispatchQueue.global(qos: .userInteractive).async{ [self] in
        
        
        
        /*ref.queryOrdered(byChild: "booktitle").observe(.value,with: { [self](snapshot) in
        // 使用self.loadingBook = [Book]() 取代 removeAll()就完成了
        self.loadingBook = [Book]()
        for item in snapshot.children{
            let book = Book(snapshot: item as! DataSnapshot)
            loadingBook!.append(book)
            print("loadingBookImageDat",type(of:loadingBook.first?.bookimage))
            }
            fetchimage()
            
        
        
            
       })*/
            
            fetch.fetchInfo(completion: {[weak self](loadBook) in
                guard let self = self else{return}
                
                if let loadBook = loadBook {
                    self.loadBook = loadBook
                    DispatchQueue.main.async {
                        tableView.reloadData()
                    }
                }
            })

        }
        
        //self.tableView.reloadData()
        dismiss(animated: true, completion: nil)
        
        // MARK:- NetWorkController to fetch data
        NetworkController.shared.fetchWord(ref: ref, completionHandler: {[weak self] (loadbook) in
            guard let self = self else{return}
            
            if let loadBook = loadbook{
                self.loadBook = loadBook
            }
        })
        
        
        
        
        //
        
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
    
    
    // MARK:- fetchimage
    func fetchimage(){
        DispatchQueue.global(qos:.userInitiated).async {
        
        do{
            
            var url = [URL]()
            print("1loadingBookImageDat",self.loadingBook.first?.bookimage)
            for i in self.loadingBook.first?.bookimage ?? []{
                url.append(URL(string: i)!)
                print("This url",i)
                print("url",url)
            }
            
            //let url = URL(string:(self.loadingBook.first?.bookimage?.first)!)
            
            let imageCache = NSCache<NSURL,UIImage>()
            /*if let image = imageCache.object(forKey: url as! NSURL){
               print("1")
            }*/
            print("im yet")
            var im = [Data]()
            for i in url{
                let imData = try Data(contentsOf: i as URL,options: [])
                im.append(imData)
                print("imData",imData)
            }
            print("im",im)
            print("im done")
            
            self.loadingBook.first?.bookimagedata = im
            print("loaingBook.first.bookimageData",self.loadingBook.first?.bookimagedata)
            print("inside loadingBook image")
            
            
        
            
            
        }catch{
            print(error.localizedDescription)
        }
        
    }
        
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
        
        return loadBook.count
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TableUIView = tableView.dequeueReusableCell(withIdentifier: "TTTableUIView", for: indexPath) as! TableUIView
        
        
        
        //cell.image_1.image = UIImage(named: imagedata[indexPath.row])
        //cell.imageData = loadingBook[indexPath.row].bookimagedata
        
        cell.update(imageData:(self.loadBook[indexPath.row].bookimage)!)
        
        cell.bookname.text = loadBook[indexPath.row].booktitle
        cell.author.text = loadBook[indexPath.row].bookauthors
        cell.owner.text = loadBook[indexPath.row].booktitle
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
                //controller?.BDImageString = loadingBook[row].bookimage
                controller?.BDISBN = loadBook[row].bookISBN
                controller?.BDBookName = loadBook[row].booktitle
                controller?.BDAuthor = loadBook[row].bookauthors
                controller?.BDImageString = loadBook[row].bookimage
                
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



