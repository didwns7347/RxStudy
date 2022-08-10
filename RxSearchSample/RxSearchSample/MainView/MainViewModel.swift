//
//  MainViewModel.swift
//  RxSearchSample
//
//  Created by yangjs on 2022/08/01.
//

import Foundation
import RxCocoa
import RxSwift

struct MainViewModel{
    let disposedBag = DisposeBag()
    
    let serachBarVM = SearchBarViewModel()
    let repoSitoryListVM = RepositoryListViewModel()
    let detailViewModel = DetailViewModel()
    
    
    init(){
        let repoResult = serachBarVM.loadAPI
            .flatMapLatest{ query in
                SearchRepositoryNetwork().searchRepository(query: query)
            }.share()
        
        let repoValue = repoResult
            .map{ result -> [Repository] in
                guard case .success(let value) = result else{
                    return []
                }
                return value
            }
        
        repoValue
            .bind(to: repoSitoryListVM.repositoryCellData)
            .disposed(by: disposedBag)
        
    }
}
