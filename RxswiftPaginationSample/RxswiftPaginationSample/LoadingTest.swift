//
//  LoadingTest.swift
//  RxswiftPaginationSample
//
//  Created by yangjs on 2022/08/31.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
class LoadingViewController : UIViewController{
    let bag = DisposeBag()
    var count = 0
    private lazy var loading : UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView()
        loading.style = .large
        return loading
    }()
    
    private lazy var loginBtn : UIButton = {
        let button = UIButton()
        button.setTitle("로그인", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .blue
        return button
    }()
    
    override func viewDidLoad() {
        view.addSubview(loading)
        view.addSubview(loginBtn)
        loading.snp.makeConstraints{
            $0.centerX.centerY.equalToSuperview()
        }
        loginBtn.snp.makeConstraints{
            $0.width.height.equalTo(100)
            $0.centerX.equalTo(loading.snp.centerX)
            $0.top.equalTo(loading.snp.bottom).offset(30)
        }
        
        loginBtn.rx.tap.bind(onNext: {
            self.count+=1
            
            self.count%2 == 0 ? self.loading.stopAnimating() : self.loading.startAnimating()
            print(self.count)
        }).disposed(by: bag)
    }
    
}
