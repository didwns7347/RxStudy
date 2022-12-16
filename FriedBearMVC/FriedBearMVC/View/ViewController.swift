//
//  ViewController.swift
//  FriedBearMVC
//
//  Created by yangjs on 2022/12/15.
//

import UIKit
import RxRelay
import RxCocoa
import RxSwift

class ViewController: UIViewController {
    @IBOutlet weak var datetieLabel: UILabel!
    let bag = DisposeBag()
    let vm = ViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        vm.viewDidLoad()
        vm.dateTimeString.bind(to: datetieLabel.rx.text).disposed(by: bag)
        
    }

    @IBAction func onTomorrow(_ sender: Any) {
        vm.moveDay(day: 1)
    }
    
    @IBAction func onYesterday(_ sender: Any) {
        vm.moveDay(day: -1)
    }
    
    @IBAction func onNow(_ sender: Any) {
        datetieLabel.rx.text.onNext("Loading...")
        vm.reload()
    }
    
    

}
/*

 JSON
 서버 모델 -> Entitiy
 -> DataModel
 //-> String
 
 MODEL
 -> Date
 
 화면 모델 -> ViewModel
 -> STring
 
 

 */
