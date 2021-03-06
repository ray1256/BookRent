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
import Alamofire


class BookAddViewController: UITableViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate {
    
    let imagePicker = UIImagePickerController()
    var ref:DatabaseReference?
    var newISBN:String?
    var barDecode:BarCodeViewController?
    var ImageData:Data?
    var imageref:DatabaseReference?
    
    var uploadURL:[String]? = []
    
    var UploadDate:String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: Date())
    }
    var owner:String? = "Nancy"
    
    
    enum rentStatus:Int{
        case Rented = 1
        case Available = 0

    }
    
    
    
    // MARK: - IBOulet
    
    @IBOutlet weak var addimage: UIImageView!
    @IBOutlet weak var AddBookName: UITextField!{
        didSet{
            AddBookName.tag = 1
            AddBookName.delegate = self
        }
    }
    @IBOutlet weak var AddBookISBN: UITextField!{
        didSet{
            AddBookISBN.tag = 2
            AddBookISBN.delegate = self
        }
    }
    
    @IBOutlet weak var AddBookAuthor: UITextField!{
        didSet{
            AddBookAuthor.tag = 3
            AddBookAuthor.delegate = self
        }
    }
    
    @IBOutlet weak var AddCategory: UITextField!{
        didSet{
            AddCategory.tag = 4
            AddCategory.delegate = self
        }
    }
    
    @IBOutlet weak var RentDay: UITextField!
    @IBOutlet weak var AddTextDescription: UITextView!
    
    @IBOutlet weak var AddTextPS: UITextView!
    
    @IBAction func AddISBNbyScan(_ sender: Any) {
        
        performSegue(withIdentifier: "toBarcode", sender: UIButton.self)
        
        
    }
    
    // MARK: - 按下Return換到下一個textfield
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextTextField = view.viewWithTag(textField.tag+1){
            textField.resignFirstResponder()
            nextTextField.becomeFirstResponder()
        }
        return true
    }
    
    // MARK: - 新增圖片按鈕
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
    
    // MARK: - TableView SetUp
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
   
    
    // MARK: - ViewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference(withPath: "Book")
        barDecode?.delegate = self
        imagePicker.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .onDrag
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        self.view.addGestureRecognizer(tap) // to Replace "TouchesBegan"
        self.AddBookISBN.text = newISBN
        registerforkeyboardNotification()
        
    }
    
    @objc func dismissKeyBoard() {
            self.view.endEditing(true)
    }
    
    
    // MARK: - keyboard Set up
    func registerforkeyboardNotification(){
        
        //          預設的NotificationCenter    觀察者｜觀察者用來通知的方法｜通知名稱｜觀察物件
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(_ :)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHiden(_ :)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    @objc func keyboardWasShown(_ notification:NSNotification){
        guard let info = notification.userInfo,let keyboardFrameValue = info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        else{return}
        
        let keyboardFrame = keyboardFrameValue.cgRectValue
        let keyboardSize = keyboardFrame.size
        
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
        tableView.contentInset = contentInsets
        // 讓側邊的Scroll可以跟我的資料一起滑動
        tableView.scrollIndicatorInsets = contentInsets
        
        
    }
    
    @objc func keyboardWillBeHiden(_ notification:NSNotification){
        
        let contentInsets = UIEdgeInsets.zero
        tableView.contentInset = contentInsets
        tableView.scrollIndicatorInsets = contentInsets
        
    }
    
    // MARK: - ImagePicker
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
                    self.addimage.image = image
                    self.ImageData = image.jpegData(compressionQuality: 1)
                }
                view.reloadInputViews()
                picker.dismiss(animated: true)
    }
    
    func cameraTake(){
        imagePicker.sourceType = .camera
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func galleryUse(){
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    
    
    // MARK: - 新增物件到資料結構
    @IBAction func addbutton(_ sender: Any) {
        
        let book1 = Book(booktitle: AddBookName.text!, bookauthors: AddBookAuthor.text!, bookISBN: AddBookISBN.text!,bookimage:[""],UploadDate: UploadDate, RentDay:Int(RentDay.text!),owner:owner,renter:nil,rentStatus:rentStatus.Available.rawValue)
        self.uploadtoFirebase(values: book1)
        //let reff = Storage.storage().reference().child("\(AddBookName!.text).png")
        //guard let imageData = addimage?.image?.jpegData(compressionQuality: 0.9) else {return}
        
        //reff.putData(imageData,metadata: nil)
        dismiss(animated: true, completion: nil)
    }
    
   
     
    

    
    // MARK: -新增資料到FireBase
   func uploadtoFirebase(values:Book){
    
    
    
    
    
    /*let bookItemRef = self.ref!.child(values.booktitle.lowercased())
    let storageImageRef = Storage.storage().reference().child("BookRentImage").child((values.booktitle))
    
    
    
   
    if addimage.image != nil{
        print("Do addimage")
        let uploadTask = storageImageRef.child("\(values.booktitle).jpeg").putData(self.ImageData!, metadata: nil, completion: {(data,error) in
        if error != nil{
            print("失敗組",error!.localizedDescription)

            return
        }
        })
    
    // 新增一個Observe觀察是否成功
        DispatchQueue.global(qos: .userInitiated).async {
    uploadTask.observe(.success, handler:{ (snapshot) in
        storageImageRef.child("\(values.booktitle).jpeg").downloadURL{(url,error)in
                            
                            if let error = error{
                                print("失敗",error.localizedDescription)
                                print("失敗2",error)
                            }else{
                                if let imageFileURL = url?.absoluteString{
                                    print("xphoto:",imageFileURL)
                                    self.uploadURL?.append(imageFileURL)
                                    
                                    let bookItem = Book(booktitle: values.booktitle, bookauthors: values.bookauthors, bookISBN: values.bookISBN, bookimage: self.uploadURL)
                                    
                                    bookItemRef.setValue(bookItem.toDictionary(),withCompletionBlock:{ (error,ref) in
                                    if error == nil {
                                        let alertController = UIAlertController(title: "Upload Success", message: "You done", preferredStyle: .alert)
                                        let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                                        
                                        alertController.addAction(alertAction)
                                        self.present(alertController, animated: true, completion: nil)
                                    }})
                                    
                                    
                                    /*bookItemRef.setValue(bookItem.ImagetoDictionary(),withCompletionBlock: {(error,ref) in
                                        if error == nil{
                                            let UploadAlertController = UIAlertController(title: "Upload Image Success", message: "Congradulation", preferredStyle: .alert)
                                            let UploadAlertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                                            UploadAlertController.addAction(UploadAlertAction)
                                            self.present(UploadAlertController, animated: true, completion: nil)
                                        }
                                    })*/
                                }
                            }
                        }
        
            
    })
    }
        
    
    
    
    
        
    }
    
    /*
    ref.child("BookName").childByAutoId().setValue(AddBookName.text)
    ref.child("BookAuthor").childByAutoId().setValue(AddBookAuthor.text)
    ref.child("BookISBN").childByAutoId().setValue(AddBookISBN.text)
    ref.child("BookImage").childByAutoId().setValue(addimage.image)
    */
    self.dismiss(animated: true, completion: nil)
    */
    
    // MARK:- SingleTon測試
        if addimage.image != nil{
            let fetch = NetworkController1()
            fetch.uploadImage(Info: values, loadImage: [addimage.image!])
        }
    
    let SuccessAlert = UIAlertController(title: "Uploaded", message: "", preferredStyle: .alert)
    let SuccessAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
    SuccessAlert.addAction(SuccessAction)
    DispatchQueue.main.async {
        self.present(SuccessAlert, animated: true, completion: nil)
    }
    
    
    }
    
    // MARK: - BarCode Detect
    func infosetup(text:String){
        let url = URL(string: "https://www.googleapis.com/books/v1/volumes?q=isbn:\(text)")!
        DispatchQueue.global(qos: .userInitiated).async {
        AF.request(url).responseJSON(completionHandler: {(response) in
            switch response.result{
            
            case .success(let data):
                print("2")
                let decoder = JSONDecoder()
                do{
                    print("url",url)
                    let decode_data = try decoder.decode(BookInfo.self, from: response.data!)
                    print("1")
                    self.AddBookAuthor.text = decode_data.items.first?.volumeInfo.authors.first
                    self.AddBookName.text = decode_data.items.first?.volumeInfo.title
                    print("decode_data",decode_data.items.first?.volumeInfo.imageLinks.thumbnail)
                    var imageURL = decode_data.items.first?.volumeInfo.imageLinks.thumbnail
                    print("imageURL",imageURL)
                    let imageData = try Data(contentsOf: imageURL!)
                    print("imageData",imageData)
                    self.addimage.image = UIImage(data: imageData)
                    //self.AddTextDescription.text = decode_data.items.first?.volumeInfo.
                
                }catch{
                    print("Error",error.localizedDescription)
                    print("Error",error)
                }
                
            default:
                break
            }
            
        })
        }
        
        
        
    }
    
    
    // MARK: - ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        barDecode?.delegate = self
    }

    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toBarcode"{
        let destination = segue.destination as? BarCodeViewController
        //BarCode的delegae透過BookAddDetail執行
        destination?.delegate = self
        }
    }
    
    
    
}

extension BookAddViewController: mailtextDelegate{
    func mailtxt(text: String) {
        AddBookISBN.text = text
        infosetup(text:text)
    }
}

struct BookInfo:Codable {
    let items:[BookNeed]
}
struct BookNeed:Codable {
    let volumeInfo:BookDetail
    //let searchInfo:Description
}

struct BookDetail:Codable {
    let title:String
    let authors:[String]
    let imageLinks:imageLink
    //let description:String
}
struct imageLink:Codable {
    let thumbnail:URL
}
struct Description:Codable {
    let textSnippet:String
}

struct authorsData:Codable{
    let firstString:String
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        firstString = try container.decode(String.self)
    }
}
