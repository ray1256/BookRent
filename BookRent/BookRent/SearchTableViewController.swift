//
//  SearchTableViewController.swift
//  BookRent
//
//  Created by 郭瑋 on 2021/9/17.
//

import UIKit
import Firebase

class SearchTableViewController: UITableViewController,UISearchResultsUpdating{
    
    func configSearchController(){
        
        // 如果設定nil 則會顯示在搜尋的相同頁面上
        searchController = UISearchController(searchResultsController: nil)
        
        // 讓SearchBar出現在tableView中
        tableView.tableHeaderView = searchController?.searchBar
        
        searchController?.searchBar.placeholder = "Search What you want"
        
        searchController?.searchResultsUpdater = self
        
    }
    
    func configDatabase(){
        
        ref = Database.database().reference(withPath: "BookRent")
        ref.queryOrdered(byChild: "booktitle").observe(.value, with: {(snapshot) in
            var OnlineItem = [Book]()
            for Items in snapshot.children{
                let book = Book(snapshot: Items as! DataSnapshot)
                OnlineItem.append(book)
            }
            self.Data = OnlineItem
        })
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text{
            filterContent(for: searchText)
            tableView.reloadData()
        }
    }
    
    
    
    
    
    
    
    var searchController: UISearchController!
    
    
    var imagedata = ["01","02","03"]
    var booknamedata = ["原子習慣","超速學習","深夜食堂"]
    var authordata = ["J","K","Z"]
    var owners = ["acer","asus","apple"]
    var lastdaydata = ["3","5","6"]
    
    
    
    
    
    var Data:[Book] = []
    var Filter:[Book] = []
    var ref:DatabaseReference!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
        configSearchController()
        configDatabase()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if searchController.isActive{
            return Filter.count
        }else{
            return Data.count
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

    
    func filterContent(for searchText: String){
        Filter = Data.filter({(data) -> Bool in
            
            let title = data.booktitle
            let is_match = title.localizedCaseInsensitiveContains(searchText)
                
            if is_match{
            return is_match
            }
            else{
                return false
            }
        })
        
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchIdentifier", for: indexPath) as! SearchTableViewCell
        
        
        let end = (searchController.isActive) ? Filter[indexPath.row] : Data[indexPath.row]
        
        
        if searchController.isActive{
            cell.searchbooktitle.text = end.booktitle
            cell.searchauthors.text = end.bookauthors
            cell.searchbookisbn.text = end.bookISBN
        
        }
        else{
            
            cell.searchbooktitle.text = end.booktitle
            cell.searchauthors.text = end.bookauthors
            cell.searchbookisbn.text = end.bookISBN
            }
        
        
        

        return cell
    }
    
    /*
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        search_on = true
        tableView.reloadData()
    }
    */

/*
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        search_on = false
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        if !search_on {
            search_on = true
            tableView.reloadData()
        }

        searchController!.searchBar.resignFirstResponder()
    }
*/
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



