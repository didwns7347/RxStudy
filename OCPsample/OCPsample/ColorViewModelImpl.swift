//
//  ColorViewModelImpl.swift
//  OCPsample
//
//  Created by yangjs on 2022/10/05.
//

import Foundation
import RxCocoa
import RxSwift

protocol ColorViewModelInput{
    func viewDidLoad()
    func didTapBlueButton()
    func didTapRedButton()
}


protocol ColorViewModelOutput{
    var buttonInfo : BehaviorRelay<String>{get}
}

protocol ColorViewModel : ColorViewModelInput, ColorViewModelOutput{}

final class ColorViewModelImpl : ColorViewModel{
    
    var buttonInfo : BehaviorRelay<String> = .init(value: "")
    private var colorUseCase : ColorUseCase?
    
    init(colorUseCase: ColorUseCase){
        self.colorUseCase = colorUseCase
    }
    
    func viewDidLoad(){
        loadColorInfo()
    }
    func didTapBlueButton(){
        colorUseCase?.updateColor(with: ColorModel(color: .blue), completion: { colorModel in
            buttonInfo.accept("파란 버튼 누적 카운트 = \(colorModel.currentBlueColor),\n빨간 버튼 누적 카운트 = \(colorModel.currentRedColor)")
        })
    }
    func didTapRedButton(){
        colorUseCase?.updateColor(with: ColorModel(color: .red), completion: { colorModel in
            buttonInfo.accept("파란 버튼 누적 카운트 = \(colorModel.currentBlueColor),\n빨간 버튼 누적 카운트 = \(colorModel.currentRedColor)")
        })
    }
    
    private func loadColorInfo() {
        colorUseCase?.getCurrentColorCount(completion: { colorModel in
            buttonInfo.accept("파란 버튼 누적 카운트 = \(colorModel.currentBlueColor),\n빨간 버튼 누적 카운트 = \(colorModel.currentRedColor)")
        })
    }
    
}
