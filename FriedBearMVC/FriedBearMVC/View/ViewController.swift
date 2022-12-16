//
//  ViewController.swift
//  FriedBearMVC
//
//  Created by yangjs on 2022/12/15.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var datetieLabel: UILabel!
    let vm = ViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        vm.viewDidLoad()
        vm.onUpadted = { [weak self] in
            DispatchQueue.main.async {
                self?.datetieLabel.text = self?.vm.dateTimeString
            }
        
        }
        
    }

    @IBAction func onTomorrow(_ sender: Any) {
        vm.moveDay(day: 1)
    }
    
    @IBAction func onYesterday(_ sender: Any) {
        vm.moveDay(day: -1)
    }
    
    @IBAction func onNow(_ sender: Any) {
        self.datetieLabel.text = "Loading..."
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
