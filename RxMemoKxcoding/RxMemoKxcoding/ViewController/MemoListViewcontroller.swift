//
//  MemoListViewcontroller.swift
//  RxMemoKxcoding
//
//  Created by yangjs on 2022/08/11.
//

import UIKit
import RxSwift
import RxCocoa


class MemoListViewcontroller: UIViewController , ViewModelBindableType{
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var addButton: UIBarButtonItem!
    let bag = DisposeBag()
     
    var viewModel : MemoListViewModel!
    func bindViewModel() {
        
        viewModel.title
            .drive(navigationItem.rx.title)
            .disposed(by: bag)
        
        viewModel.memoList
            .bind(to: self.listTableView.rx.items(cellIdentifier: "cell")){row,memo,cell in
                cell.textLabel?.text = memo.content
            }.disposed(by: bag)
            
        
        addButton.rx.action = viewModel.makeCreateAction()
        
        listTableView.rx.action = viewModel.detailAction()
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

   

}
