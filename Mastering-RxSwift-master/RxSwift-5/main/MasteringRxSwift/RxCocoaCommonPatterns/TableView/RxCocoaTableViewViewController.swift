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


class RxCocoaTableViewViewController: UIViewController {
   
   @IBOutlet weak var listTableView: UITableView!
    let nameObservable = Observable.of(appleProducts.map{$0.name})
    let productObservable = Observable.of(appleProducts)
   let priceFormatter: NumberFormatter = {
      let f = NumberFormatter()
      f.numberStyle = NumberFormatter.Style.currency
      f.locale = Locale(identifier: "Ko_kr")
      
      return f
   }()
   
   
   let bag = DisposeBag()
   
         
   
   override func viewDidLoad() {
      super.viewDidLoad()
       productObservable
           .bind(to: listTableView.rx.items(cellIdentifier: "productCell", cellType: ProductTableViewCell.self))
       {[weak self] row,model,cell in
           cell.productNameLabel.text = model.name
           cell.summaryLabel.text = model.summary
           cell.priceLabel.text = self?.priceFormatter.string(for: model.price)
           cell.categoryLabel.text = model.category
           
       }.disposed(by: bag)
     
   }
}




