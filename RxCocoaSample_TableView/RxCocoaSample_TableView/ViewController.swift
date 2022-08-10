//
//  ViewController.swift
//  RxCocoaSample_TableView
//
//  Created by yangjs on 2022/08/05.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var listTableView: UITableView!

    let bag = DisposeBag()
    
    let nameObservable = Observable.of(appleProducts.map{$0.name})
    let productObservable = Observable.of(appleProducts)
    let priceFormatter: NumberFormatter = {
       let f = NumberFormatter()
       f.numberStyle = NumberFormatter.Style.currency
       f.locale = Locale(identifier: "Ko_kr")
       
       return f
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listTableView.rowHeight = UITableView.automaticDimension
        listTableView.estimatedRowHeight = 190
        // Do any additional setup after loading the view.
        
        //#1
//        nameObservable.bind(to:listTableView.rx.items){ tableview, row, element in
//            let cell = tableview.dequeueReusableCell(withIdentifier: "standardcell", for: (IndexPath(row: row, section: 0)))
//            cell.textLabel?.text = element
//            return cell
//        }.disposed(by: bag)
        
        //#2
//        nameObservable.bind(to:listTableView.rx.items(cellIdentifier: "standardCell")){ row, element, cell in
//            cell.textLabel?.text = element
//        }.disposed(by: bag)
        

   
       //#3
        productObservable.bind(to: listTableView.rx.items(cellIdentifier: "productCell", cellType: ProductCellTableViewCell.self)){[weak self] row,object,cell in
            cell.categoryLabel.text = object.category
            cell.priceLabel.text = self?.priceFormatter.string(for: object.price)
            cell.summaryLabel.text = object.summary
            cell.productNameLabel.text = object.name
        }.disposed(by: bag)
        
//        listTableView.rx.modelSelected(Product.self)
//            .subscribe(onNext:{ product in
//                print(product.name)
//            }).disposed(by: bag)
//
//        listTableView.rx.itemSelected
//            .subscribe(onNext:{ [weak self] indexPath in
//                self?.listTableView.deselectRow(at: indexPath, animated: true)
//
//            }).disposed(by: bag)
        Observable.zip(listTableView.rx.itemSelected, listTableView.rx.modelSelected(Product.self))
            .bind {[weak self] (indexPath, product) in
                self?.listTableView.deselectRow(at: indexPath, animated: true)
                print(product.name)
            }
            .disposed(by: bag)
        
        //델리게이트 선택시 다음 코드로 해야함.
        listTableView.rx.setDelegate(self)
            .disposed(by: bag)
       
    }

}
extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function)
    }
}
