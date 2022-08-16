//
//  MemoComposeViewController.swift
//  RxMemoKxcoding
//
//  Created by yangjs on 2022/08/11.
//

import UIKit
import RxCocoa
import RxSwift

class MemoComposeViewController: UIViewController , ViewModelBindableType{
    @IBOutlet weak var cancel: UIBarButtonItem!
    @IBOutlet weak var save: UIBarButtonItem!
    @IBOutlet weak var contentTextView: UITextView!
    let bag = DisposeBag()
    var viewModel : MemoComposeViewModel!
    func bindViewModel() {
        viewModel.title
            .drive(navigationItem.rx.title)
            .disposed(by: bag)
        
        viewModel.initalText
            .drive(contentTextView.rx.text)
            .disposed(by: bag)
        
        cancel.rx.action = viewModel.cancelAction
        
        save.rx.tap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .withLatestFrom(contentTextView.rx.text.orEmpty)
            .bind(to: viewModel.saveAction.inputs)
            .disposed(by: bag)
        
        
        let willShowObservable = NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification)
            .compactMap{$0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue}
            .map{$0.cgRectValue.height}
        
        let willHideObservable = NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification)
            .map{noti -> CGFloat in 0}
        
        let keyboardObservable = Observable.merge(willShowObservable,willHideObservable)
            .share()
        
        keyboardObservable
            .toContentInset(of: contentTextView)
            .bind(to: contentTextView.rx.contentInset)
            .disposed(by: bag)
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        contentTextView.becomeFirstResponder()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if contentTextView.isFirstResponder{
            contentTextView.resignFirstResponder()
        }
    }

}


extension ObservableType where Element == CGFloat{
    func toContentInset(of textView : UITextView) -> Observable<UIEdgeInsets>{
        return map{ height in
            var inset = textView.contentInset
            inset.bottom = height
            return inset
            
        }
    }
}
