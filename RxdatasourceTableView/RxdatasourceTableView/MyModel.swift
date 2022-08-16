//
//  MyModel.swift
//  RxdatasourceTableView
//
//  Created by yangjs on 2022/08/16.
//

import Foundation
import RxDataSources

struct MyModel{
    var message:String
    var isDone: Bool = false
}
extension MyModel : IdentifiableType, Equatable{
    var identitiy: String{
        return UUID().uuidString
    }
}
