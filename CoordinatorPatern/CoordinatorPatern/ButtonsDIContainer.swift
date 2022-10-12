//
//  ButtonsDIContainer.swift
//  CoordinatorPatern
//
//  Created by yangjs on 2022/10/05.
//

import Foundation
import UIKit

class ButtonsDIContainer{
    func makeButtonCoordinator(navigationController : UINavigationController) -> ButtonsCoordinator{
        return ButtonsCoordinator(navigationController: navigationController, dependencies: self)
    }
    
    private func makeButtonsUseCaseImpl()-> ButtonsUseCase{
        return ButtonsUseCaseImpl()
    }
    
    private func makeButtonsViewModel(actions: ButtonsViewModelActions)-> ButtonsViewModel{
        return ButtonsViewModelImpl(actions: actions, buttonsUseCase: makeButtonsUseCaseImpl())
    }
}

extension ButtonsDIContainer : ButtonsCoordinatorDependencies{
    func makeButtonViewController(actions: ButtonsViewModelActions) -> ButtonsViewController {
        return ButtonsViewController.create(with: makeButtonsViewModel(actions: actions))
    }
    func makeRedViewController(tapCount: Int) -> UIViewController {
        return RedViewController.create(tapCount: tapCount)
    }
    func makeBlueViewController(tapCount: Int) -> UIViewController {
        return BlueViewController.create(tapCount: tapCount)
    }
}
