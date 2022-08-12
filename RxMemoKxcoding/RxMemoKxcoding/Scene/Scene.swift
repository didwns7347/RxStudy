//
//  Scene.swift
//  RxMemoKxcoding
//
//  Created by yangjs on 2022/08/11.
//

import UIKit

enum Scene{
    case list(MemoListViewModel)
    case detail(MemoDetailViewModel)
    case compose(MemoComposeViewModel)
    
}

extension Scene{
    func instantiate(from storyboard : String = "Main") -> UIViewController{
        let storyboard = UIStoryboard(name:storyboard, bundle: nil)
        
        switch self{
        case .list(let memoListVIewModel):
            guard let nav = storyboard.instantiateViewController(identifier: "ListNav") as? UINavigationController else {
                fatalError()
            }
            guard var listVC = nav.viewControllers.first as? MemoListViewcontroller else {
                fatalError()
            }
            DispatchQueue.main.async {
                listVC.bind(viewModel: memoListVIewModel)
            }
          
            
            return nav
            
        case .detail(let detailVM):
            guard var detailVC = storyboard.instantiateViewController(identifier: "DetailVC") as? DetailViewController else{
                fatalError()
            }
            DispatchQueue.main.async {
                detailVC.bind(viewModel: detailVM)
            }
            return detailVC
            
        case .compose(let composeVM):
            guard let nav = storyboard.instantiateViewController(identifier: "ComposeNav") as? UINavigationController else{
                fatalError()
            }
            
            guard var composeVC = nav.viewControllers.first as? MemoComposeViewController else{
                fatalError()
            }
            DispatchQueue.main.async {
                composeVC.bind(viewModel: composeVM)
            }
            return nav
        }
    }
}

