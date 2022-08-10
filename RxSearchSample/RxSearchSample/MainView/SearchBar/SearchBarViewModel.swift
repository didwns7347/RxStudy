//
//  SearchBarViewModel.swift
//  RxSearchSample
//
//  Created by yangjs on 2022/08/01.
//

import Foundation
import RxSwift
import RxCocoa

struct SearchBarViewModel{
    let inputCompleted = PublishRelay<Void>()
    let queryText = PublishRelay<String?>()
    let loadAPI : Observable<String>

    init(){
        loadAPI = inputCompleted
            .withLatestFrom(queryText){
                $1 ?? ""
            }.filter{ word in
                word.count != 0
            }.distinctUntilChanged()
    }
}
