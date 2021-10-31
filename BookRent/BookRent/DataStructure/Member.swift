//
//  Member.swift
//  BookRent
//
//  Created by 郭瑋 on 2021/10/26.
//

import Foundation
import Firebase

class Member:Book{
    var NickName:String
    var MemberImage:String?
    var RentedBookCount:Int
    var BorrowedBookCount:Int
    
    
    
    init(NickName:String,MemberImage:String?,RentedBookCount:Int,BorrowedBookCount:Int,Book:Book) {
        self.NickName = NickName
        self.MemberImage = MemberImage
        self.RentedBookCount = RentedBookCount
        self.BorrowedBookCount = BorrowedBookCount
        
        super.init(booktitle: Book.booktitle, bookauthors: Book.bookauthors, bookISBN: Book.bookauthors, bookimage:Book.bookimage, UploadDate: Book.UploadDate, RentDay: Book.RentDay, owner: NickName, renter: Book.renter, rentStatus: Book.rentStatus)
    }
    
    
    override init(snapshot:DataSnapshot){
        self.NickName = ""
        self.MemberImage = ""
        self.RentedBookCount = 0
        self.BorrowedBookCount = 0
        super.init()
        
        
        let snapshotValue = snapshot.value as! [String:AnyObject]
        self.NickName = snapshotValue["NickName"] as! String
        self.MemberImage = snapshotValue["MemberImage"] as? String
        self.RentedBookCount = snapshotValue["RentedBookCount"] as! Int
        self.BorrowedBookCount = snapshotValue["BorrowedBookCount"] as! Int
        
        self.booktitle = snapshotValue["Book"]?["booktitle"] as! String
        self.bookauthors = snapshotValue["Book"]?["bookauthors"] as! String
        self.bookISBN = snapshotValue["Book"]?["bookISBN"] as! String
        //self.bookimage = snapshotValue["Book"]?["bookimage"] 
        self.RentDay = snapshotValue["Book"]?["RentDay"] as! Int
        self.renter = snapshotValue["Book"]?["Renter"] as? String
        self.rentStatus = snapshotValue["Book"]?["rentStatus"] as! Int
        
    }
    
    override func toDictionary() -> Any {
        return [
            "NickName":NickName,
            "MemberImage":MemberImage,
            "RentedBookCount":RentedBookCount,
            "BorrowedBookCount":BorrowedBookCount,
            "Book":["booktitle":booktitle,
                    "bookimage":bookimage,
                    "bookauthors":bookauthors,
                    "bookISBN":bookISBN,
                    "UploadDate":UploadDate,
                    "RentDay":RentDay,
                    "Owner":owner,
                    "Renter":renter,
                    "rentStatus":rentStatus
            ]
        ]
    }
}
