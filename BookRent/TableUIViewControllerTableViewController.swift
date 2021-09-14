//
//  TableUIViewControllerTableViewController.swift
//  BookRent
//
//  Created by 郭瑋 on 2021/9/6.
//

import UIKit

class TableUIViewControllerTableViewController: UITableViewController{
                                                /*UICollectionViewDelegate,UICollectionViewDataSource {*/
    
    
    
    var imagedata = ["01","02","03"]
    var booknamedata = ["原子習慣","超速學習","深夜食堂"]
    var authordata = ["J","K","Z"]
    var owners = ["acer","asus","apple"]
    var lastdaydata = ["3","5","6"]
    
    let nib = UINib(nibName: "TableUIView", bundle: nil)
    
    
    
        
    override func viewDidLoad() {
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
        return imagedata.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 286
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TableUIView = tableView.dequeueReusableCell(withIdentifier: "TTTableUIView", for: indexPath) as! TableUIView
        
        //cell.image_1.image = UIImage(named: imagedata[indexPath.row])
        cell.bookname.text = booknamedata[indexPath.row]
        cell.author.text = authordata[indexPath.row]
        cell.owner.text = owners[indexPath.row]
        cell.count_day.text = lastdaydata[indexPath.row]
        cell.backgroundColor = .init(red: 201, green: 148, blue: 115, alpha: 0)

        // Configure the cell...

        return cell
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}
