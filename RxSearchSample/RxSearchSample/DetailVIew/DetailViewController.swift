//
//  DetailViewController.swift
//  RxSearchSample
//
//  Created by yangjs on 2022/08/03.
//

import UIKit
import WebKit
import RxCocoa
import RxSwift
import SnapKit

class DetailViewController : UIViewController,WKUIDelegate{
    lazy var webView : WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    let disposeBag = DisposeBag()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func bind(vm:DetailViewModel){
        vm.loadWebView.subscribe(onNext:{ [weak self] urlString in
            guard let self = self else {return}
            let url = URL(string: urlString)!
            let request = URLRequest(url: url)
            self.webView.load(request)
        }).disposed(by: disposeBag)
    }
    
    
}
private extension DetailViewController{
    func attribute(){
        
    }
    
    func layout(){
        view.addSubview(webView)
        webView.snp.makeConstraints{
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
