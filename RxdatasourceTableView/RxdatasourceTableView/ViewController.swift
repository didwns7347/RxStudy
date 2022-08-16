//
//  ViewController.swift
//  RxdatasourceTableView
//
//  Created by yangjs on 2022/08/16.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

class ViewController: UIViewController {
    var sections = [
        MySection(headerTitle: "첫 번째", items: [MyModel(message: "jake"), MyModel(message:"jake의 iOS")]),
        MySection(headerTitle: "두 번째", items: [MyModel(message:"jake의 iOS앱 개발 알아가기"), MyModel(message:"jake의 iOS앱 개발 알아가기\njake의 iOS앱 개발 알아가기")]),
        MySection(headerTitle: "세 번째", items: [MyModel(message:"jake의 iOS앱 개발 알아가기\njake의 iOS앱 개발 알아가기\njake의 iOS앱 개발 알아가기\njake의 iOS앱 개발 알아가기")])
    ]
    
    /// row 데이터 적용 (section은 dataSource.titleForHeaderInSection으로 설정)
    var dataSource = RxTableViewSectionedReloadDataSource<MySection> { dataSource, tableView, indexPath, item in
        let cell = tableView.dequeueReusableCell(withIdentifier: MyTableViewCell.className, for: indexPath) as! MyTableViewCell
        cell.bind(mySectionItem: item)
        return cell
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

