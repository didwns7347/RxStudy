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

class RxCocoaAlertViewController: UIViewController {
   
   let bag = DisposeBag()
   
   @IBOutlet weak var colorView: UIView!
   
   @IBOutlet weak var oneActionAlertButton: UIButton!
   
   @IBOutlet weak var twoActionsAlertButton: UIButton!
   
   @IBOutlet weak var actionSheetButton: UIButton!
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
       oneActionAlertButton.rx.tap
           .flatMap{[unowned self] in self.info(title: "CurrentColor", message: self.colorView.backgroundColor?.rgbHexString)
               
           }.subscribe(onNext:{[unowned self] actionType in
               switch actionType{
               case .cancel:
                   break
               case.ok:
                   print(self.colorView.backgroundColor?.rgbHexString ?? "nil")
               }
           }).disposed(by: bag)
       
       twoActionsAlertButton.rx.tap
           .flatMap{[unowned self] in self.alert(title: "CurrentColor", message: self.colorView.backgroundColor?.rgbHexString)
               
           }.subscribe(onNext:{[unowned self] actionType in
               switch actionType{
               case .cancel:
                   print("CANCEL !!!!")
               case.ok:
                   self.colorView.backgroundColor = .black
                   
               }
           }).disposed(by: bag)
       
       actionSheetButton.rx.tap
           .flatMap{[unowned self] in
               self.colorActionSheet(colors: [UIColor.black,UIColor.red,UIColor.green,UIColor.blue], title: "SELECT COLOR !!")
           }
           .subscribe(onNext:{[unowned self] color in
               print(color.rgbHexString)
               self.colorView.backgroundColor = color
           }).disposed(by: bag)
   }
}

enum ActionType {
   case ok
   case cancel
}

extension UIViewController{
    func info(title:String, message:String? = nil) -> Observable<ActionType>{
        return Observable.create{ [weak self] observer in
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
                observer.onNext(.ok)
                observer.onCompleted()
            }
            alert.addAction(okAction)
            
            self?.present(alert, animated: true)
            
            return Disposables.create {
                alert.dismiss(animated: true)
            }
        }
    }
    
    func alert(title:String,message:String? = nil)-> Observable<ActionType>{
        return Observable.create{ [weak self] observer in
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
                observer.onNext(.ok)
                observer.onCompleted()
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .default){ _ in
                observer.onNext(.cancel)
                observer.onCompleted()
            }
            
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            
            self?.present(alert, animated: true)
            
            return Disposables.create {
                alert.dismiss(animated: true)
            }
        }
    }
    
    func colorActionSheet(colors: [UIColor], title:String, message:String? = nil) -> Observable<UIColor>{
        return Observable.create{ [weak self] observer in
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            colors.forEach { color in
                alert.addAction(UIAlertAction(title: color.rgbHexString, style: .default){ _ in
                    observer.onNext(color)
                    observer.onCompleted()
                })
                
            }
            self?.present(alert, animated: true)
            return Disposables.create {
                alert.dismiss(animated: true)
            }
            
        }
    }
}
