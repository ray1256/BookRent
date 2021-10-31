//
//  NetworkController.swift
//  BookRent
//
//  Created by 郭瑋 on 2021/10/9.
//

import UIKit
import Alamofire
import Firebase

class NetworkController{
    static let shared = NetworkController()
    
    let imageCache = NSCache<NSURL,UIImage>()
    
    
    func fetchImage(url:URL,completionHandler:@escaping(UIImage?) -> ()){
        
        AF.request(url).responseData(completionHandler: {(response) in
                                        
            switch response.result{
            case .success(let data):
                let image = UIImage(data: data)!
                completionHandler(image)
                return
                
            case .failure(let error):
                print("Error",error)
                print("Error_description",error.localizedDescription)
                
        
            }
            
        })
    }
    
    func fetchWord(ref:DatabaseReference,completionHandler:@escaping([Book]?) -> ()){
        ref.queryOrdered(byChild: "booktitle").observe(.value, with: {(snapshot) in
            var onlineBooks = [Book]()
            for i in snapshot.children{
                let books = Book(snapshot: i as! DataSnapshot)
                onlineBooks.append(books)
            }
           completionHandler(onlineBooks)
            return
        })
    }
    
}
