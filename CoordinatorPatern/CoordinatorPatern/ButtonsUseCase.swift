//
//  ButtonsUseCase.swift
//  CoordinatorPatern
//
//  Created by yangjs on 2022/10/05.
//

import Foundation
protocol ButtonsUseCase{
    var redButtonCnt : Int { get set}
    var blueButtonCnt: Int{ get set}
}

final class ButtonsUseCaseImpl : ButtonsUseCase{
    var redButtonCnt: Int{
        get {
            return UserDefaults.standard.integer(forKey: "redButton")
        }set{
            UserDefaults.standard.set(newValue, forKey: "redButton")
        }
    }
    
    var blueButtonCnt: Int{
        get{
            return UserDefaults.standard.integer(forKey: "blueButton")
        }set{
            UserDefaults.standard.set(newValue, forKey: "blueButton")
        }
    }
}
