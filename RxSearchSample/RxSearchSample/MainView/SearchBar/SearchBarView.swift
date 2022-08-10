//
//  SearchBarView.swift
//  RxSearchSample
//
//  Created by yangjs on 2022/08/01.
//


import RxSwift
import RxCocoa
import UIKit

class SearchBarView : UISearchBar{
    let disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    func bind(_ vm:SearchBarViewModel ){
        self.rx.text
            .bind(to: vm.queryText)
            .disposed(by: disposeBag)
        
        
        self.rx.searchButtonClicked
            .bind(to: vm.inputCompleted)
            .disposed(by: disposeBag)
        
        vm.inputCompleted
            .asSignal()
            .emit(to: self.rx.endEditing)
            .disposed(by: disposeBag)
            
    }
}
private extension SearchBarView {
    func attribute(){
        
    }
    
    func layout(){
        
    }
}


extension Reactive where Base:SearchBarView{
    var endEditing: Binder<Void>{
        return Binder(base){ a,b in
            print("END EDITTING")
            a.endEditing(true)
        }
    }
}
