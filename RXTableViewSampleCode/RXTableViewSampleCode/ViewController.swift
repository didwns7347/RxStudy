//
//  ViewController.swift
//  RXTableViewSampleCode
//
//  Created by yangjs on 2022/10/18.
//

import UIKit
import RxCocoa
import RxSwift
class ViewController: UIViewController {
    var currentPage: Int = 0
    let bag = DisposeBag()
    let vm = ViewModel()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("1234")
        // Do any additional setup after loading the view.
        bind(vm: vm)
        attribute()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.vm.loadMore.onNext(())
    }
    func bind(vm:ViewModel){

        
        vm.modelList
            .bind(to: self.tableView.rx.items(cellIdentifier: "cell", cellType: BeerListCell.self)){(index,element, cell) in
                cell.getConfigure(with: element)
            }.disposed(by: bag)
        
        Observable.zip(tableView.rx.itemSelected, self.tableView.rx.modelSelected(Int.self))
            .subscribe(onNext:{ indexPath, element in
                self.tableView.deselectRow(at: indexPath, animated: false)
            }).disposed(by: bag)
        
        tableView.rx.didScroll.subscribe { [weak self] _ in
                    guard let self = self else { return }
                    let offSetY = self.tableView.contentOffset.y
                    let contentHeight = self.tableView.contentSize.height

                    if offSetY > (contentHeight - self.tableView.frame.size.height - 100) {
                        vm.loadMore.onNext(())
                    }
                }
                .disposed(by: bag)
        
        tableView.rx.itemSelected.subscribe { indexPath in
            
        }
        
//        vm.loadMore.onNext(())

     
    }
    private func attribute(){

    }
    
    
    
    
    

}

