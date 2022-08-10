//
//  ViewController.swift
//  RxSearchSample
//
//  Created by yangjs on 2022/08/01.
//

import UIKit
import SnapKit
import RxSwift
class ViewController: UIViewController {
    let searchBar = SearchBarView()
    let repositoryListView = RepositoryListView()
    let detailVC = DetailViewController()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("VIEW LOADED")

        // Do any additional setup after loading the view.
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        print("INIT")
        attribute()
        layout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func bind(_ vm:MainViewModel){
        searchBar.bind(vm.serachBarVM)
        repositoryListView.bind(vm: vm.repoSitoryListVM)
        detailVC.bind(vm: vm.detailViewModel)
        vm.repoSitoryListVM.cellTapped.map{ repo in
            return repo.url
        }.bind(to: vm.detailViewModel.loadWebView)
            .disposed(by: disposeBag)
        
        vm.detailViewModel.loadWebView.subscribe(onNext:{[weak self] _ in
            guard let self = self else {return}
            self.present(self.detailVC, animated: true)
        }).disposed(by: disposeBag)
        
       
    
    }

}

private extension ViewController{
    func attribute(){
        title = "깃허브 ID 검색"
        
    }
    
    func layout(){
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.trailing.leading.equalToSuperview().inset(10)
        }
        view.addSubview(repositoryListView)
        repositoryListView.snp.makeConstraints{
            $0.top.equalTo(searchBar.snp.bottom).offset(10)
            $0.leading.bottom.trailing.equalToSuperview()
        }
    }
}

