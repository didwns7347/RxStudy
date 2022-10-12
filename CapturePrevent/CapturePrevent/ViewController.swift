//
//  ViewController.swift
//  CapturePrevent
//
//  Created by yangjs on 2022/09/26.
//

import UIKit

class ViewController: UIViewController {

 
    @IBOutlet weak var sampleImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "HELLO"
        NotificationCenter.default.addObserver(self, selector: #selector(showCapturedView), name: UIApplication.userDidTakeScreenshotNotification, object: nil)

    }
    
    @objc func showCapturedView(){
        let capturedView = CapturedView.init(frame: self.view.bounds)
        self.view.addSubview(capturedView)
        
        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
            self.navigationController?.popViewController(animated: true)
        }
    }
}

