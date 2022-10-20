//
//  ViewModel.swift
//  RXTableViewSampleCode
//
//  Created by yangjs on 2022/10/18.
//

import Foundation
import RxSwift
import RxCocoa

enum Action{
    case load([Int])
    case loadMore([Int])
}
class ViewModel{
    let bag = DisposeBag()
    let totoalPage = 20
    var currentPage = 1

    let modelList = BehaviorRelay<[Beer]>(value: [])

//    let loadList = Observable<[Int]>.of([])
    let loadMore = PublishSubject<Void>()
    init(service : ListService = ListService()){
        bind()
            
    }
    
    func bind(){
        loadMore.subscribe{[weak self] _ in
            self?.getList()
        }.disposed(by: bag)
    }
    func getList(){
        if self.currentPage == totoalPage{
            return
        }
      
        loadBeerList(page: self.currentPage)
            .subscribe( onSuccess: { data  in
                let result = try? JSONDecoder().decode([Beer].self, from: data)
                self.handleResult(data: result ?? [])
            }).disposed(by: bag)
     
    }
    
    func handleResult(data:[Beer]){
        
        currentPage += 1
        let oldData = modelList.value
        modelList.accept(oldData+data)
        currentPage+=1
        
    }
    
    func loadBeerList(page:Int) -> Single<Data>{
        let url = URL(string: "https://api.punkapi.com/v2/beers?page=\(page)")
        let request = URLRequest(url: url! ,timeoutInterval: 1)
        let session = URLSession.shared
        return session.rx.data(request: request).asSingle()

    }


 
 
}
