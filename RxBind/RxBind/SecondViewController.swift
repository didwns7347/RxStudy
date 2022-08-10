//
//  SecondViewController.swift
//  RxBind
//
//  Created by yangjs on 2022/08/04.
//

import UIKit
import WebKit
class SecondViewController : UIViewController{
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Sencond view!!!! ")
        
        if let url = URL(string: "https://www.naver.com"){
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}
