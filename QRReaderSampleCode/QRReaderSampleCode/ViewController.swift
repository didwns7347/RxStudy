//
//  ViewController.swift
//  QRReaderSampleCode
//
//  Created by yangjs on 2022/09/29.
//

import UIKit
import AVFoundation
class ViewController: UIViewController , AVCaptureMetadataOutputObjectsDelegate {
    var isReading = false
    var captureSession : AVCaptureSession? = nil
    var videoPreviewLayer : AVCaptureVideoPreviewLayer? = nil
    var canReading : Bool = true
    @IBOutlet weak var ScanView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        requestCameraPermission()
    }
    
    func requestCameraPermission(){
        switch AVCaptureDevice.authorizationStatus(for: .video)
        {
        case .authorized:
            guard self.startReading() else{
                print("Starting ...")
                return
            }
            break
        case .denied:
            showPermissionErrorAlert(message: "카메라 접근 권한 허용 설정이 필요합니다.")
            break
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted{
                    print("\(#function) AVAuthorizationStatusNotDetermined")
                    DispatchQueue.main.async {
                        guard self.startReading() else{
                            return
                        }
                    }
                }else{
                    DispatchQueue.main.async {
                        self.showPermissionErrorAlert(message: "카메라 접근 권한 허용 설정이 필요합니다")
                    }
                }
            }
            break
        case .restricted:
            break
            
        @unknown default:
            print("ERROR ERROR")
            break
        }
    }
    
    func showPermissionErrorAlert(message : String) {
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "확인", style: .default)
        alert.addAction(ok)
        
        self.present(alert, animated: true)
    }
    
    func startReading()-> Bool{
        
        if isReading == true{
            return false
        }
        captureSession = AVCaptureSession.init()
        do{
            guard let captureDevice = AVCaptureDevice.default(for: .video) else{
                return false
            }
            
            let input = try AVCaptureDeviceInput.init(device: captureDevice)
            
            if captureSession?.canAddInput(input) == true{
                captureSession?.addInput(input)
            }
            
            let captureMetadataOutput = AVCaptureMetadataOutput.init()
            if captureSession?.canAddOutput(captureMetadataOutput) == true {
                captureSession?.addOutput(captureMetadataOutput)
            }
            
            let dispatchQueue = DispatchQueue.init(label:"myQueue")
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: dispatchQueue)
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
            
            
        }catch{
            return false
        }
        videoPreviewLayer = AVCaptureVideoPreviewLayer.init(session: captureSession!)
        videoPreviewLayer?.videoGravity = .resizeAspectFill
        videoPreviewLayer?.frame = ScanView.layer.bounds
        self.ScanView.layer.addSublayer(self.videoPreviewLayer!)
        DispatchQueue.global().async {
            self.captureSession?.startRunning()
        }
        
        
        isReading = true
        
        
        
        return true
        
        
    }
    
    func stopReading(){
        isReading = false
        captureSession?.stopRunning()
        captureSession = nil
        videoPreviewLayer = nil
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        if canReading == false {
            return
        }
        
        if let metadataObject = metadataObjects.first {
            
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            
            self.stopReading()
            print(stringValue)
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        }
        DispatchQueue.main.async {
            
        }
        //viewDidLoad()
    }
    
}

