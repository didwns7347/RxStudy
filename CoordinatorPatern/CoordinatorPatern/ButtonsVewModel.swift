//
//  ButtonsVewModel.swift
//  CoordinatorPatern
//
//  Created by yangjs on 2022/10/05.
//

import Foundation
struct ButtonsViewModelActions{
    let showRedButtons: (Int) -> Void
    let showBlueButtons : (Int) -> Void
}

protocol ButtonsViewModelInput{
    func didTapRedButton()
    func didTapBlueButton()
}

protocol ButtonsViewModelOutput{
    
}

protocol ButtonsViewModel : ButtonsViewModelInput, ButtonsViewModelOutput{
    
}


final class ButtonsViewModelImpl : ButtonsViewModel{
    private let actions : ButtonsViewModelActions
    private var buttonsUseCase : ButtonsUseCase
    
    init(actions: ButtonsViewModelActions, buttonsUseCase: ButtonsUseCase) {
        self.actions = actions
        self.buttonsUseCase = buttonsUseCase
    }
    
    //Input
    
    func didTapRedButton(){
        buttonsUseCase.redButtonCnt += 1
        actions.showRedButtons(buttonsUseCase.redButtonCnt)
    }
    
    func didTapBlueButton(){
        buttonsUseCase.blueButtonCnt += 1
        actions.showBlueButtons(buttonsUseCase.blueButtonCnt)
    }
}

