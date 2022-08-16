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
            .bind(to:listTableView.rx.items(dataSource: viewModel.dataSource))
            .disposed(by: bag)
        
        
        addButton.rx.action = viewModel.makeCreateAction()
        
        
 
        listTableView.rx.itemSelected
            .subscribe(onNext:{ [weak self] index in
                self?.listTableView.deselectRow(at: index, animated: true)
            })
            .disposed(by: bag)
        

        listTableView.rx.modelSelected(Memo.self)
            .subscribe(onNext:{ memo in
                let detailVM = MemoDetailViewModel(title: "메모보기",memo: memo, sceneCoordinator:self.viewModel.sceneCoordinator , storage: self.viewModel.storage)
                let detailScene = Scene.detail(detailVM)

              self.viewModel.sceneCoordinator.transition(to: detailScene, using: .push, animiate: true)

            })
            .disposed(by: bag)
        
//        listTableView.rx.modelSelected(Memo.self)
//            .throttle(.microseconds(500), scheduler: MainScheduler.instance)
//            .bind(to: viewModel.detailAction.inputs)
//            .disposed(by: bag)
//
        listTableView.rx.modelDeleted(Memo.self)
            .throttle(.microseconds(500), scheduler: MainScheduler.instance)
            .bind(to: viewModel.deleteAction.inputs)
            .disposed(by: bag)


      
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

   

}
