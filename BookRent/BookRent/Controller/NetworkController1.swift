//
//  NetworkController.swift
//  BookRent
//
//  Created by 郭瑋 on 2021/10/14.
//

import Foundation
import UIKit
import Firebase
import FirebaseStorage



class NetworkController1{
    
    static let shared = NetworkController1()
    
    let  ref = Database.database().reference(withPath: "BookRent")
    var storage = Storage.storage().reference().child("BookRentImage")
    
    var book = [Book]()
    var ImageURLArray = [String]()
    
    func fetchInfo(ref:DatabaseReference,completion:@escaping([Book]?) -> ()){
        ref.queryOrdered(byChild: "booktitle").observe(.value, with: {(snapshot) in
            var OnlineItem = [Book]()
            for item in snapshot.children{
                let books = Book(snapshot: item as! DataSnapshot)
                OnlineItem.append(books)
            }
            self.book = OnlineItem
            
            completion(self.book)
        })
    }
    
    
    func uploadImage(Info:Book,loadImage:[UIImage]){
        // 資料夾
        storage = storage.child(Info.booktitle.lowercased())
        var index = 1
        for item in loadImage{
            guard let loadImage = item.jpegData(compressionQuality: 1) else{return}
            let uploadTask = storage.child("\(Info.booktitle)_\(index).jpeg").putData(loadImage,metadata: nil,completion: {(Data,error) in
                if error != nil{
                    print("Error",error?.localizedDescription)
                    return
                }
            })
            
            
            DispatchQueue.global(qos: .default).async {
                uploadTask.observe(.success, handler: {/*[weak self]*/(snapshot) in
                    print("UnSuccess")
                    //guard let self = self else{return}
                    print("Success")
                    self.storage.child("\(Info.booktitle)_\(index).jpeg").downloadURL(completion:{(imageurl,error) in
                                print("imageurl",imageurl)
                                if let imageURL = imageurl?.absoluteString{
                                    print("imageURL",imageURL)
                                    self.ImageURLArray.append(imageURL)
                                    let addbook = Book(booktitle: Info.booktitle, bookauthors: Info.bookauthors, bookISBN: Info.bookISBN, bookimage: self.ImageURLArray,key:"", UploadDate:Info.UploadDate,RentDay:Info.RentDay,owner:Info.owner, renter: "",rentStatus: Info.rentStatus)
                                
                                    self.uploadInfo(Info: addbook)
                                    index = index + 1

                                }else{print("error",error?.localizedDescription)}})
                })
                let addbook = Book(booktitle: Info.booktitle, bookauthors: Info.bookauthors, bookISBN: Info.bookISBN, bookimage: self.ImageURLArray)
                print("AddBook",addbook)
                // 先上傳一份到FireBase
                self.uploadInfo(Info: addbook)
            
                
            }
            
        }
        
        
    }
    
    func uploadInfo(Info:Book){
        let uploadref = ref.child("\(Info.booktitle)".lowercased())
        uploadref.setValue(Info.toDictionary(),withCompletionBlock: {(error,ref) in
            if error != nil{
                print("Error",error?.localizedDescription)
            }
        })
    }
}
