//
//  RepositoryListViewModel.swift
//  RxSearchSample
//
//  Created by yangjs on 2022/08/01.
//

import Foundation
import RxSwift
import RxCocoa

struct RepositoryListViewModel {
    let repositoryCellData = PublishRelay<[Repository]>()
    let cellData : Driver<[Repository]>
    let cellTapped = PublishRelay<Repository>()
    var repositories = [Repository]()
    init(){
        self.cellData = repositoryCellData
            .asDriver(onErrorJustReturn: [])

    }
    
    
}
