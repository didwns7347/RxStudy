//
//  ViewController.swift
//  RxcocoaSample_CODE
//
//  Created by yangjs on 2022/08/04.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    let disposeBag = DisposeBag()
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var redSlider: UISlider!
    
    @IBOutlet weak var blueValue: UILabel!
    @IBOutlet weak var greenValue: UILabel!
    @IBOutlet weak var redValue: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //let colorChange = PublishRelay<Int>()
        
        
        redSlider.rx.value
            .map{
                "\(Int($0))"
            }
            .bind(to:redValue.rx.text)
            .disposed(by: disposeBag)
        
        blueSlider.rx.value
            .map{
                "\(Int($0))"
            }
            .bind(to:blueValue.rx.text)
            .disposed(by: disposeBag)
        
        greenSlider.rx.value
            .map{
                "\(Int($0))"
            }
            .bind(to:greenValue.rx.text)
            .disposed(by: disposeBag)
        
        Observable.combineLatest(redSlider.rx.value, greenSlider.rx.value, blueSlider.rx.value)
            .map { r, g, b in
                return UIColor(red: CGFloat(r)/255, green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha: 1.0)
            }.bind(to:colorView.rx.backgroundColor)
            .disposed(by: disposeBag)
        resetButton.rx.tap
            .subscribe(onNext:{ [weak self]  in
                self?.colorView.backgroundColor = .black
                self?.redSlider.value = 0
                self?.greenSlider.value = 0
                self?.blueSlider.value = 0
                self?.updateComponentLabel()
            })
            .disposed(by: disposeBag)
        
    }
    
    func updateComponentLabel(){
        self.redValue.text = "\(Int(redSlider.value))"
        self.greenValue.text = "\(Int(greenSlider.value))"
        self.blueValue.text = "\(Int(blueSlider.value))"
    }
    
    
}
