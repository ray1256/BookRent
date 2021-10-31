//
//  Book.swift
//  BookRent
//
//  Created by 郭瑋 on 2021/9/22.
//

import Foundation
import Firebase

class Book{
    var booktitle:String
    var bookauthors:String
    var bookISBN:String
    var bookimage:[String]?
    var UploadDate:String!
    var RentDay:Int?
    //var booktoexpired:Int
    var key:String
    var ref:DatabaseReference?
    var owner:String?
    var renter:String?
    var rentStatus:Int!
    
    
    init(booktitle:String,bookauthors:String,bookISBN:String,bookimage:[String]?,key:String = "",UploadDate:String,RentDay:Int?,owner:String?,renter:String?,rentStatus:Int?){//},bookimagedata:[Data]?){//,booktoexpired:Int) {
        self.key = key
        self.booktitle = booktitle
        self.bookauthors = bookauthors
        self.bookISBN = bookISBN
        self.bookimage = bookimage
        self.ref = nil
        self.UploadDate = UploadDate
        self.RentDay = RentDay
        self.owner = owner
        self.renter = renter
        self.rentStatus = rentStatus
    }
    
    init(booktitle:String,bookauthors:String,bookISBN:String,bookimage:[String]?,key:String = ""){//},bookimagedata:[Data]?){//,booktoexpired:Int) {
        self.key = key
        self.booktitle = booktitle
        self.bookauthors = bookauthors
        self.bookISBN = bookISBN
        self.bookimage = bookimage
        //self.booktoexpired = booktoexpired
        self.ref = nil
    }
    
    
    // 透過Firebase的init
    init(snapshot: DataSnapshot) {
            key = snapshot.key
            let snapshotValue = snapshot.value as! [String: AnyObject]
            booktitle = snapshotValue["booktitle"] as! String
            bookauthors = snapshotValue["bookauthors"] as! String
            bookISBN = snapshotValue["bookISBN"] as! String
            bookimage = snapshotValue["bookimage"] as? [String]
            //booktoexpired = snapshotValue["bookexpired"] as! Int
            UploadDate = snapshotValue["UploadDate"] as! String
            RentDay = snapshotValue["RentDay"] as? Int
            owner = snapshotValue["owner"] as? String
            renter = snapshotValue["renter"] as? String
            rentStatus = snapshotValue["rentStatus"] as? Int
            ref = snapshot.ref
        }
    
    init(){
        
        self.booktitle = ""
        self.bookauthors = ""
        self.bookISBN = ""
        self.bookimage = [""]
        self.UploadDate = ""
        self.rentStatus = 0
        self.RentDay = 0
        self.renter = ""
        self.ref = nil
        self.key = ""
        
    }
    
    
    func toDictionary()->Any{
        return [
            "booktitle":booktitle,
            "bookauthors":bookauthors,
            "bookISBN":bookISBN,
            "bookimage":bookimage,
            "UploadDate":UploadDate,
            "RentDay":RentDay,
            "owner":owner,
            "renter":renter,
            "rentStatus":rentStatus
            
            //"booktoexpired":booktoexpired
        ]
    }
    
    /*func ImagetoDictionary() -> Any{
        return ["bookimage":bookimage]
    }
    */
}



