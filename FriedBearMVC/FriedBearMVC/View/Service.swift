//
//  Repository.swift
//  FriedBearMVC
//
//  Created by yangjs on 2022/12/15.
//

import Foundation
class Service {
    let repository = Repository()
    
    var currentModel = Model(currentDateTime: Date())
    
    func fetchNow(onComplete: @escaping (Model) -> Void){
        repository.fetchNow { [weak self] entity in
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm'Z'"
            guard let now = formatter.date(from: entity.currentDateTime) else {return }
            let model = Model(currentDateTime: now)
            self?.currentModel = model
            onComplete(model)
        }
    }
    func moveDay(day : Int){
        guard let moveDate = Calendar.current.date(byAdding: .day,value: day ,to: self.currentModel.currentDateTime)
        else { return }
        self.currentModel.currentDateTime = moveDate
    }
   
    
 
}
