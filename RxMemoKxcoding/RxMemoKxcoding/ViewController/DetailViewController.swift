//
//  DetailViewController.swift
//  RxMemoKxcoding
//
//  Created by yangjs on 2022/08/11.
//

import UIKit
import RxSwift
import RxCocoa
import Action
class DetailViewController: UIViewController , ViewModelBindableType{
    var viewModel : MemoDetailViewModel!
    let bag = DisposeBag()
    @IBOutlet weak var contentTableView: UITableView!
    @IBOutlet weak var delete: UIBarButtonItem!
    @IBOutlet weak var share: UIBarButtonItem!
    @IBOutlet weak var edit: UIBarButtonItem!
    
    
    func bindViewModel() {
        viewModel.title
            .drive(navigationItem.rx.title)
            .disposed(by: bag)
        
        viewModel.contents
            .bind(to:contentTableView.rx.items){tv ,row ,string in
                switch row{
                case 0:
                    let cell = tv.dequeueReusableCell(withIdentifier: "contentCell", for: IndexPath(row: 0, section: row))
                    cell.textLabel?.text = string
                    return cell
                case 1:
                    let cell = tv.dequeueReusableCell(withIdentifier: "dateCell", for: IndexPath(row: 0, section: row))
                    cell.textLabel?.text = string
                    return cell
                default:
                    return UITableViewCell()
                }
                
            }.disposed(by: bag)
        edit.rx.action = viewModel.makeEditAction()
        delete.rx.action = viewModel.deleteAction()
        
        share.rx.tap
            .throttle(.microseconds(500), scheduler: MainScheduler.instance)
            .withUnretained(self)
            .subscribe(onNext:{ vc, _ in
                let memo = vc.viewModel.selectedMemo.content
                let activityVC = UIActivityViewController(activityItems: [memo], applicationActivities: nil)
                vc.present(activityVC, animated: true)
                
            }).disposed(by: bag)
//        
//        var backbutton = UIBarButtonItem(title: nil, style: .done, target: nil ,action: nil)
//        viewModel.title
//            .drive(backbutton.rx.title)
//            .disposed(by: bag)
//        
//        backbutton.rx.action = viewModel.popAction
//        navigationItem.hidesBackButton = true
//        navigationItem.leftBarButtonItem = backbutton
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}
