//
//  ViewModel.swift
//  FriedBearMVC
//
//  Created by yangjs on 2022/12/15.
//

import Foundation
import RxRelay

class ViewModel{
    let service = Service()
    var onUpadted : ()->Void = {}
   let dateTimeString = BehaviorRelay(value: "Loading...")
    
     
    private func dateToString(date:Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일 HH시 mm분"
        return formatter.string(from: date )
    }
    
    func viewDidLoad(){
        reload()
    }
    
    func moveDay(day : Int){
        service.moveDay(day: day)
        dateTimeString.accept( dateToString(date : service.currentModel.currentDateTime))
    }
    
    func reload(){
        //model -> viewModel
        service.fetchNow { [weak self] model in
            guard let self = self else {return}
            let dateString = self.dateToString(date: model.currentDateTime)
            self .dateTimeString.accept(dateString)
        }
    }
}
