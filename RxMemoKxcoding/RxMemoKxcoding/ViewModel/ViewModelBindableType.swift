//
//  ViewModelBindableType.swift
//  RxMemoKxcoding
//
//  Created by yangjs on 2022/08/11.
//

import UIKit

protocol ViewModelBindableType{
    associatedtype viewModelType
    
    var viewModel : viewModelType! { get set }
    func bindViewModel()
}

extension ViewModelBindableType where Self: UIViewController{
    mutating func bind(viewModel:Self.viewModelType){
        self.viewModel = viewModel
        loadViewIfNeeded()
        bindViewModel()
    }
}
