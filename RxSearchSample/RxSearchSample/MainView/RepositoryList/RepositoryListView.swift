//
//  RepositoryListView.swift
//  RxSearchSample
//
//  Created by yangjs on 2022/08/01.
//

import UIKit
import RxSwift
import RxCocoa
import WebKit

class RepositoryListView : UITableView{
    let disposeBag = DisposeBag()
    var items = [Repository]()
    let webView = WKWebView()
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        attribute()
        
    }
    
    func bind(vm:RepositoryListViewModel){
       
        vm.cellData
            .drive(self.rx.items){tv, row, item in
                let index = IndexPath(row: row, section: 0)
                self.items.append(item)
                let cell = tv.dequeueReusableCell(withIdentifier: "repocell", for: index) as! RepositoryListCell
                cell.repository = item
                return cell
            }
            .disposed(by: disposeBag)
        
        
        self.rx.modelSelected(Repository.self)
            .bind(to:vm.cellTapped)
            .disposed(by: disposeBag)

        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}
private extension RepositoryListView{
    func attribute(){
        self.backgroundColor = .white
        self.register(RepositoryListCell.self, forCellReuseIdentifier: "repocell")
        self.separatorStyle = .singleLine
        self.rowHeight = 100
    }
}
