//
//  ListService.swift
//  RXTableViewSampleCode
//
//  Created by yangjs on 2022/10/18.
//

import Foundation
import RxSwift
import RxCocoa

struct ListService{
    func getList(page:Int) -> Observable<[Int]>{
        let result = Observable.of((0...9).map{$0+10*page})
        return result
    }
}
