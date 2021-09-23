//
//  BookAddViewController.swift
//  BookRent
//
//  Created by 郭瑋 on 2021/9/16.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
import GoogleBooksApiClient

class BookAddViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    let imagePicker = UIImagePickerController()
    var ref:DatabaseReference?
    @IBOutlet weak var addimage: UIImageView!
    
    @IBOutlet weak var AddBookISBN: UITextField!
    @IBOutlet weak var AddBookName: UITextField!
    @IBOutlet weak var AddBookAuthor: UITextField!
    @IBAction func addimage(_ sender: UIGestureRecognizer) {
        
        let controller = UIAlertController(title: "選取上傳方式", message: nil, preferredStyle: .alert)
        let controllerAction_camera = UIAlertAction(title: "相機", style: .default){(_ ) in
            self.cameraTake()
        }
        let controllerAction_gallery = UIAlertAction(title: "相簿", style: .default, handler: {(_ ) in
            self.galleryUse()})
        let controllerAction_cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        
        controller.addAction(controllerAction_camera)
        controller.addAction(controllerAction_gallery)
        controller.addAction(controllerAction_cancel)
        
        self.present(controller, animated: true, completion: nil)
    }
    
    /*
    
    let session = URLSession.shared
    let client = GoogleBooksApiClient(session: session)
    
    
    let req = GoogleBooksApi.VolumeRequest.List(query: "Google")
    let task: URLSessionDataTask = client.invoke(
        req,
        onSuccess: { volumes in NSLog("\(volumes)") },
        onError: { error in NSLog("\(error)") }
    )
    task.resume()
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference(withPath: "Book")
        imagePicker.delegate = self
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
                    self.addimage.image = image
                }
                
                picker.dismiss(animated: true)
    }
    
    
    @IBAction func addbutton(_ sender: Any) {
        
        let book1 = Book(booktitle: AddBookName.text!, bookauthors: AddBookAuthor.text!, bookISBN: AddBookISBN.text!)
        self.uploadtoFirebase(values: book1)
        //let reff = Storage.storage().reference().child("\(AddBookName!.text).png")
        //guard let imageData = addimage?.image?.jpegData(compressionQuality: 0.9) else {return}
        
        //reff.putData(imageData,metadata: nil)
       
        
    }
    
    func cameraTake(){
        imagePicker.sourceType = .camera
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func galleryUse(){
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
   func uploadtoFirebase(values:Book){
    
    let bookItem = Book(booktitle: values.booktitle, bookauthors: values.bookauthors, bookISBN: values.bookISBN)
    
    let bookItemRef = self.ref!.child(values.booktitle.lowercased())
    bookItemRef.setValue(bookItem.toDictionary(),withCompletionBlock:{ (error,ref) in
        if error == nil {
            let alertController = UIAlertController(title: "Upload Success", message: "You done", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(alertAction)
            self.present(alertController, animated: true, completion: nil)
        }})
    
    /*
    ref.child("BookName").childByAutoId().setValue(AddBookName.text)
    ref.child("BookAuthor").childByAutoId().setValue(AddBookAuthor.text)
    ref.child("BookISBN").childByAutoId().setValue(AddBookISBN.text)
    ref.child("BookImage").childByAutoId().setValue(addimage.image)
    */
    self.dismiss(animated: true, completion: nil)
    }

}
