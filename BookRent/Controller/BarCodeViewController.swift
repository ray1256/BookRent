//
//  BarCodeViewController.swift
//  BookRent
//
//  Created by 郭瑋 on 2021/9/23.
//

import UIKit
import Vision
import AVFoundation

class BarCodeViewController: UIViewController,AVCapturePhotoCaptureDelegate{
    
    // object 控制捕捉活動以及協調資料流
    var captureSession:AVCaptureSession!
    var backCamera: AVCaptureDevice?
    var cameraPreviewLayer:AVCaptureVideoPreviewLayer?
    var captureOutput: AVCapturePhotoOutput?
    
    var shutterButton: UIButton!
    var closeButton: UIButton!
    var delegate:mailtextDelegate?
    var payloadtxt:String?
    public var payload1:String?
    
    lazy var detectBarCodeRequest: VNDetectBarcodesRequest = {
        return VNDetectBarcodesRequest(completionHandler: {(request, error) in
            guard error == nil else{
                self.showAlert(withTitle:"BarCode Error")
                return
            }
            
            // update VC with result
            self.processClassification(for:request)
        })
    }()
    
    func processClassification(for request:VNRequest){
        
        if let bestResult = request.results?.first as? VNBarcodeObservation{
            if let payload = bestResult.payloadStringValue{
                DispatchQueue.main.async {
                    let alert = UIAlertController()
                    alert.addAction(UIAlertAction(title: payload, style: .default, handler:{(action:UIAlertAction)->Void in
                        
                        self.delegate?.mailtxt(text: payload)
                        print("payload",payload)
                        //self.dismiss(animated: true, completion: nil)
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
                
            }
            }
        else{
            self.showAlert(withTitle: "BarDeocode Error")
        }
        
    }
    
    
    
    // provide us with UIImage captured from the live video
    // convert to CIImage
    
    
    @IBAction func dragDiss(_ sender: UIGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func ButtonDis(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
        
        checkPermission()
        setupCameraLiveView()
        self.navigationController?.isToolbarHidden = true
        
        
        addShutterButton()
        self.tabBarController?.tabBar.isHidden = true
        //self.navigationController?.navigationBar.isHidden = true

        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        // 每次當使用者要進入這個App都要確保相機可以使用
        checkPermission()
    }
    
    
    
    
    // 隱藏最上面的狀態列
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    // 確認相機存取狀態，採取的動作
    private func checkPermission(){
        
        let mediaType = AVMediaType.video
        // return AVauthorizationStatus
        let status = AVCaptureDevice.authorizationStatus(for: mediaType)
        
        switch status {
        case .denied,.restricted:
            displayNotAuthorizedUI()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: mediaType, completionHandler: {(granted) in
                guard granted != true else{return}
                
                // The UI must be updated on the main thread
                DispatchQueue.global().async{
                    // 因為是在DispatchQueue上執行
                    self.displayNotAuthorizedUI()
                }
                
            })
        
        default:
            break
        }
    }
    // MARK: - 設定Camera
    private func setupCameraLiveView(){
        // 取得Permission之後，設定Camera Session
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .hd1920x1080
        
        // 設定Video device
        // 用DiscoverySession來尋找符合條件的AVCaptureDevice存進去
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInDualCamera], mediaType: AVMediaType.video, position: .back)
        // Arrray 滿足這個需求的
        let devices = deviceDiscoverySession.devices
        for device in devices{
            if device.position == AVCaptureDevice.Position.back{
                // 將符合條件的存進去backCamera
                backCamera = device
            }
        }
        
        guard let backCamera = backCamera else{
            showAlert(withTitle:"Camera Error")
            return
        }
        
        // MARK: -設定output and input stream
        do {
            // 新增backCamera進去AVCaptureDeviceInput
            let captureDeviceInput = try AVCaptureDeviceInput(device: backCamera)
            // 將AVCaptureDeviceInput新增Input進captureSession
            captureSession.addInput(captureDeviceInput)
        }catch{
            showAlert(withTitle:"Camera Error")
            return
        }
        
        captureOutput = AVCapturePhotoOutput()
        // Tell photo capture to prepare resource for future capture
        // 設定output的格式
        captureOutput?.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey:AVVideoCodecType.jpeg])], completionHandler: nil)
        captureSession.addOutput(captureOutput!)
        
        // Add Preview Layer
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        cameraPreviewLayer?.videoGravity = .resizeAspectFill
        // connection -> describing the AVCaptureInputPort to which the preview layer is connected
        cameraPreviewLayer?.connection?.videoOrientation = .portrait
        cameraPreviewLayer?.frame = view.frame
        
        
        self.view.layer.insertSublayer(cameraPreviewLayer!, at: 0)
        
        captureSession.startRunning()

    }
    
   
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        // AVCapturePhoto產生出的photo，先轉換成Data型態，再將image轉換成UIImage
        // 再將image轉換成CIImage
        if let imageData = photo.fileDataRepresentation(),let image = UIImage(data: imageData){
            guard let CiImage = CIImage(image: image) else{
                fatalError("Unable to create \(CIImage.self) from \(image).")
            
            }
            
            // Perform the Classficcation request on a background thread
            DispatchQueue.global(qos: .userInteractive).sync{
            // 要求處理單張照片
            let handler = VNImageRequestHandler(ciImage:CiImage,orientation:CGImagePropertyOrientation.up,options: [:])
            do {
                // 執行識別
                try handler.perform([self.detectBarCodeRequest])
            }catch{
                self.showAlert(withTitle:"Error")
            }
            }
        }
    }
    
    private func displayNotAuthorizedUI(){
        let label = UILabel(frame: CGRect(x:0, y:0,width: view.frame.width*0.8,height:20))
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = "Please Granted Access"
        label.sizeToFit()
        
        
        
        let button = UIButton(frame: CGRect(x: 0, y: label.frame.height, width: view.frame.width*0.8, height: 35))
        
        button.layer.cornerRadius = 10
        button.setTitle("Grant Access", for: .normal)
        button.backgroundColor = UIColor(displayP3Red: 4/255, green: 92/255, blue: 198/255, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        // 點選Button要做的動作 #selector裡面裝@objc的func
        button.addTarget(self, action: #selector(openSettings), for: .touchUpInside)
        
        
        
        
        
        // 用UIView來裝這些
        let containerView = UIView(frame:CGRect(x: view.frame.width*0.1, y: (view.frame.height-label.frame.height+8+button.frame.height)/2, width: view.frame.width*0.8, height: label.frame.height+8+button.frame.height))
        
        
        containerView.addSubview(label)
        containerView.addSubview(button)
        view.addSubview(containerView)
    }
    
    @objc private func openSettings(){
        // "設定"頁面的URL
        let settingURL = URL(string: UIApplication.openSettingsURLString)!
        // 打開 "設定"頁面的URL
        UIApplication.shared.open(settingURL){ _ in
            self.checkPermission()
        }
    }
    
    
    
    
    
    private func addShutterButton(){
        
        let width:CGFloat = 75
        let height = width
        shutterButton = UIButton(frame: CGRect(x: (view.frame.width - width)/2, y: view.frame.height - height - 32, width: width, height: height))
        
        

        
        shutterButton.layer.cornerRadius = width/2
        shutterButton.backgroundColor = UIColor.init(displayP3Red: 1, green: 1, blue: 1, alpha: 0.8)
        shutterButton.backgroundColor = UIColor.gray
        // 觸碰到會有highlighted特效
        shutterButton.showsTouchWhenHighlighted = true
        shutterButton.addTarget(self, action: #selector(captureImage), for: .touchUpInside)
        
        closeButton = UIButton(frame: CGRect(x: view.frame.width - 70, y: 0, width: 100, height: 100))
        closeButton.setImage(UIImage(named: "multiply"), for: .normal)
        closeButton.addTarget(self, action: #selector(closedown), for: .touchUpInside)
        
        view.addSubview(closeButton)
        view.addSubview(shutterButton)
        
    }
    
    @objc func captureImage(){
        let setting = AVCapturePhotoSettings()
        captureOutput?.capturePhoto(with: setting, delegate: self)
    }
    
    @objc func closedown(){
        
        self.captureSession.stopRunning()
        self.cameraPreviewLayer?.removeFromSuperlayer()
        //self.delegate?.mailtxt(text:payloadtxt ?? "")
        dismiss(animated: true, completion: nil)
    }
    
    
    private func showAlert(withTitle: String){
        let alertController = UIAlertController(title: withTitle, message: "", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    
    override func viewWillLayoutSubviews() {
        cameraPreviewLayer?.connection?.videoOrientation = .portrait
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return .portrait
    }
    
    override open var shouldAutorotate: Bool{
        return false
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
   /*
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? BookAddViewController
            destination?.newISBN? = payloadtxt!
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        }
 */
    }
    
   
    
    
    





protocol mailtextDelegate{
    func mailtxt(text:String)
}

