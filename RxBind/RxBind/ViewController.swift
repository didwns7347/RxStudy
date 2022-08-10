//
//  ViewController.swift
//  RxBind
//
//  Created by yangjs on 2022/08/03.
//

import UIKit
import RxCocoa
import RxSwift
class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var button: UIButton!
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = ""
        textField.becomeFirstResponder()
        
        //해당 코드는 메인 스레드에서 실행된다는 보장은 없음.
        textField.rx.text
            .subscribe(onNext:{ [weak self] value in
                self?.label.text = value
            })
            .disposed(by: disposeBag)
        
        //bind사용
        //bind
        textField.rx.text
            .bind(to:label.rx.text)
            .disposed(by:disposeBag)
        
        button.rx.tap
            .subscribe(onNext:{ [weak self] in
                guard let self = self else {return }
                let vc = self.storyboard!.instantiateViewController(identifier: "webview") as! SecondViewController
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            }).disposed(by: disposeBag)
    }


}

