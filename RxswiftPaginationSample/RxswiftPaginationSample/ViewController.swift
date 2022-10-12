//
//  ViewController.swift
//  RxswiftPaginationSample
//
//  Created by yangjs on 2022/08/30.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Alamofire
import Then


class ViewController: UIViewController {
    private var dataSource = [Photo]()
    private var currentPage = -1
    private var bag = DisposeBag()
    
    private let tableView = UITableView(frame: .zero).then {
        $0.allowsSelection = false
        $0.backgroundColor = UIColor.clear
        $0.separatorStyle = .none
        $0.bounces = true
        $0.showsVerticalScrollIndicator = true
        $0.contentInset = .zero
        
        $0.register(MyCell.self, forCellReuseIdentifier: MyCell.Contant.id)
        $0.rowHeight = UITableView.automaticDimension
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(tableView)
        self.tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.tableView.dataSource = self
        
        self.getPhotos()
        
        self.tableView.rx.prefetchRows
            .compactMap(\.last?.row)
            .withUnretained(self)
            .bind{ vc,row in
                guard row == vc.dataSource.count - 1 else
                {
                    return
                }
                vc.getPhotos()
            }.disposed(by: bag)
    }


}

extension ViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        (tableView.dequeueReusableCell(withIdentifier: MyCell.Contant.id, for: indexPath) as! MyCell).then {
              $0.prepare(imageURL: self.dataSource[indexPath.row].urlString)
            }
    }
}
private extension ViewController{
    func getPhotos(){
        self.currentPage += 1
        let url = "https://api.unsplash.com/photos/"
        let headers:HTTPHeaders = ["Authorization":"Client-ID UmddSpS6mMjRcrRw3zSmfWV-Me6vEjBaSbP1Ag2m-B8"]
        let photoRequest = PhotoRequest(page: self.currentPage)
        
        AF.request(url,method: .get,parameters: photoRequest.toDictionary(),headers: headers)
            .responseDecodable(of:[Photo].self){[weak self] response in
                switch response.result{
                case let .success(photos):
                    self?.dataSource.append(contentsOf: photos)
                    self?.tableView.reloadData()
                    DispatchQueue.main.asyncAfter(deadline:.now()+0.5) {
                        UIView.performWithoutAnimation {
                            self?.tableView.performBatchUpdates(nil,completion: nil)
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
