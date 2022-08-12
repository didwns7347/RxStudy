//
//  TransitionModel.swift
//  RxMemoKxcoding
//
//  Created by yangjs on 2022/08/11.
//

import Foundation
enum TransitionStyle {
    case root
    case push
    case modal
}

enum TransitionError : Error{
    case navigationControllerMissing
    case cannotPop
    case unknown
}
