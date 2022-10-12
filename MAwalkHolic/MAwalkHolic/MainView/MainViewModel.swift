//
//  MainViewModel.swift
//  MAwalkHolic
//
//  Created by yangjs on 2022/10/12.
//

import Foundation
import RxSwift
import RxCocoa
import HealthKit

class MainViewModel{
    let bag = DisposeBag()
    let stepListLoaded = PublishRelay<[StepModel]>()
    let authorizeSuccess = PublishSubject<Bool>()
    let didEnterForeground = PublishSubject<Void>()
   
    let healthStore = HKHealthStore()
    
    init(){
        let enter = didEnterForeground.map{true}
        
        let getStepList = Observable.merge(enter,authorizeSuccess.filter{$0 == true})
        
        getStepList.subscribe(onNext:{ _ in
            let calender = Calendar.current
            var interval = DateComponents()
            interval.day = 1
            
            var anchorComponents = calender.dateComponents([.day, .month, .year], from: NSDate() as Date)
            anchorComponents.hour = 0
            let anchorDate = calender.date(from: anchorComponents)
            
            let stepQuery = HKStatisticsCollectionQuery(quantityType: HKObjectType.quantityType(forIdentifier: .stepCount)!, quantitySamplePredicate: nil, options: .cumulativeSum, anchorDate: anchorDate!, intervalComponents: interval as DateComponents)
            stepQuery.initialResultsHandler = { [self] query, results, error in
                let endDate = NSDate()
                // 오늘로부터 30일간의 걸음수 데이터를 가져오도록 진행
                let startDate = calender.date(byAdding: .day, value: -30, to: endDate as Date, wrappingComponents: false)
                var stepList = [StepModel]()
                if let myResults = results {
                    myResults.enumerateStatistics(from: startDate!, to: endDate as Date) { statistics, stop in
                        if let quantity = statistics.sumQuantity() {
                            let date = statistics.startDate
                            let steps = quantity.doubleValue(for: HKUnit.count())
                            //self.stepDataList.append("\(date): \(steps)")
                            let model = StepModel(step: steps, date: date)
                            stepList.append(model)
                            
                        }
                    }
                    self.stepListLoaded.accept(stepList.reversed())
                    
                }
            }
            self.healthStore.execute(stepQuery)
        }).disposed(by: bag)
        
        
    }
}
    
