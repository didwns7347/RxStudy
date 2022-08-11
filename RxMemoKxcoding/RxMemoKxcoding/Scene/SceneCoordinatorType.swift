//
//  SceneCoordinatorType.swift
//  RxMemoKxcoding
//
//  Created by yangjs on 2022/08/11.
//

import Foundation
import RxSwift

protocol SceneCoordinatorType{
    @discardableResult
    func transition(to scene : Scene, using style: TransitionStyle, animiate:Bool) -> Completable
    
    @discardableResult
    func close(animated: Bool) -> Completable
}
