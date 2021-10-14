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
    var bookimagedata:[Data]?
    //var booktoexpired:Int
    var key:String
    var ref:DatabaseReference?
    
    init(booktitle:String,bookauthors:String,bookISBN:String,bookimage:[String]?,key:String = ""){//},bookimagedata:[Data]?){//,booktoexpired:Int) {
        self.key = key
        self.booktitle = booktitle
        self.bookauthors = bookauthors
        self.bookISBN = bookISBN
        self.bookimage = bookimage
        self.bookimagedata = nil
        //self.booktoexpired = booktoexpired
        self.ref = nil
    }
    
    init(booktitle:String,bookauthors:String,bookISBN:String,bookimage:[String]?,key:String = "",bookimagedata:[Data]?){//},bookimagedata:[Data]?){//,booktoexpired:Int) {
        self.key = key
        self.booktitle = booktitle
        self.bookauthors = bookauthors
        self.bookISBN = bookISBN
        self.bookimage = bookimage
        self.bookimagedata = bookimagedata
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
            bookimage = snapshotValue["bookimage"] as? [String]            //booktoexpired = snapshotValue["bookexpired"] as! Int
            ref = snapshot.ref
        }
    
    func toDictionary()->Any{
        return [
            "booktitle":booktitle,
            "bookauthors":bookauthors,
            "bookISBN":bookISBN,
            "bookimage":bookimage
            //"booktoexpired":booktoexpired
        ]
    }
    
    /*func ImagetoDictionary() -> Any{
        return ["bookimage":bookimage]
    }
    */
}


