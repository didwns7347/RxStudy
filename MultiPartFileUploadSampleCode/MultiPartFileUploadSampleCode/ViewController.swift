//
//  ViewController.swift
//  MultiPartFileUploadSampleCode
//
//  Created by yangjs on 2022/11/15.
//

import UIKit

class ViewController: UIViewController {
    let images = [UIImage(named: "fig"), UIImage(named: "lime"), UIImage(named: "strawberry"), UIImage(named: "watermelon")]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let service = AFService()
//        service.editActivity(imageData: images[0])
        let session = URLSessionService()
        session.requestIdentify()
    }
    
    


}
