//
//  Copyright (c) 2019 KxCoding <kky0317@gmail.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

enum ApiError: Error {
    case badUrl
    case invalidResponse
    case failed(Int)
    case invalidData
}

class RxCocoaURLSessionViewController: UIViewController {
    
    @IBOutlet weak var listTableView: UITableView!
    
    let list = BehaviorSubject(value: [Book]())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        list
            .bind(to: listTableView.rx.items(cellIdentifier: "cell")) { row, element, cell in
                cell.textLabel?.text = element.title
                cell.detailTextLabel?.text = element.desc
            }
            .disposed(by: rx.disposeBag)
        
        fetchBookList()
    }
    
    
    func fetchBookList() {
        let response = Observable.just(booksUrlStr)
            .map{
                URL(string: $0)!
            }.map{
                URLRequest(url: $0)
            }.flatMap{
                URLSession.shared.rx.data(request: $0)
            }.map{ data in
                BookList.parse(data: data)
            }.asDriver(onErrorJustReturn: [])
        
        
//        let response = Observable<[Book]>.create { observer in
//            let session = URLSession.shared
//            let task = session.dataTask(with: url) { [weak self] (data, response, error) in
//                defer {
//                    DispatchQueue.main.async { [weak self] in
//                        self?.listTableView.reloadData()
//                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
//                    }
//                }
//
//                if let error = error {
//                    print(error)
//                    observer.onError(error)
//                    return
//                }
//
//                guard let httpResponse = response as? HTTPURLResponse else {
//                    print("Invalid Response")
//                    observer.onCompleted()
//                    return
//                }
//
//                guard (200...299).contains(httpResponse.statusCode) else {
//                    print(httpResponse.statusCode)
//                    observer.onCompleted()
//                    return
//                }
//
//                guard let data = data else {
//                    fatalError("Invalid Data")
//                    observer.onCompleted()
//                    return
//                }
//
//                do {
//                    let decoder = JSONDecoder()
//                    let bookList = try decoder.decode(BookList.self, from: data)
//
//                    if bookList.code == 200 {
//                        observer.onNext(bookList.list)
//                    } else {
//                        observer.onNext([])
//                    }
//                } catch {
//                    observer.onError(error)
//                }
//            }
//            task.resume()
//            return Disposables.create{
//                task.cancel()
//            }
//        }.asDriver(onErrorJustReturn: [])
//
        response
            .drive(list)
            .disposed(by: rx.disposeBag)
        response
            .map{ _ in
                false
            }.startWith(true)
            .drive(UIApplication.shared.rx.isNetworkActivityIndicatorVisible)
            .disposed(by: rx.disposeBag)
    }
}
